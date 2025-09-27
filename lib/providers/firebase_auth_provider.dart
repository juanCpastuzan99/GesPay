import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  User? _currentUser;
  String _errorMessage = '';
  bool _isLoading = false;

  User? get user => _currentUser;
  String get error => _errorMessage;
  bool get isLoading => _isLoading;

  FirebaseAuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(firebase_auth.User? firebaseUser) {
    final newUser = firebaseUser != null ? User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
    ) : null;
    
    // Solo actualizar si el usuario realmente cambió
    if (_currentUser?.id != newUser?.id) {
      _currentUser = newUser;
      notifyListeners();
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      print('🔐 Intentando iniciar sesión con: $email');

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('✅ Usuario autenticado: ${credential.user?.uid}');

      if (credential.user != null) {
        await _saveUserToFirestore(credential.user!);
        return true;
      }
      return false;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('❌ Error de autenticación: ${e.code} - ${e.message}');
      _errorMessage = _getErrorMessage(e.code);
      return false;
    } catch (e) {
      print('❌ Error inesperado: $e');
      _errorMessage = 'Error inesperado: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      print('📝 Creando usuario: $email');

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('✅ Usuario creado: ${credential.user?.uid}');

      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
        await _saveUserToFirestore(credential.user!);
        return true;
      }
      return false;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('❌ Error creando usuario: ${e.code} - ${e.message}');
      _errorMessage = _getErrorMessage(e.code);
      return false;
    } catch (e) {
      print('❌ Error inesperado: $e');
      _errorMessage = 'Error inesperado: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveUserToFirestore(firebase_auth.User firebaseUser) async {
    try {
      final userDoc = _firestore.collection('users').doc(firebaseUser.uid);
      await userDoc.set({
        'id': firebaseUser.uid,
        'email': firebaseUser.email,
        'name': firebaseUser.displayName ?? '',
        'createdAt': Timestamp.fromDate(firebaseUser.metadata.creationTime ?? DateTime.now()),
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      print('Error guardando usuario en Firestore: $e');
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      
      print('🚪 Cerrando sesión...');
      await _auth.signOut();
      _currentUser = null;
      print('✅ Sesión cerrada correctamente');
    } catch (e) {
      print('❌ Error cerrando sesión: $e');
      _errorMessage = 'Error al cerrar sesión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No existe una cuenta con este email';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'email-already-in-use':
        return 'Ya existe una cuenta con este email';
      case 'weak-password':
        return 'La contraseña es muy débil';
      case 'invalid-email':
        return 'El email no es válido';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde';
      default:
        return 'Error de autenticación: $errorCode';
    }
  }
}
