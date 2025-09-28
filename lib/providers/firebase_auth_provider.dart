import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  firebase_auth.FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  
  User? _currentUser;
  String _errorMessage = '';
  bool _isLoading = false;
  bool _firebaseAvailable = false;

  User? get user => _currentUser;
  String get error => _errorMessage;
  bool get isLoading => _isLoading;
  bool get firebaseAvailable => _firebaseAvailable;

  FirebaseAuthProvider() {
    _initializeFirebase();
  }

  void _initializeFirebase() {
    try {
      _auth = firebase_auth.FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      _firebaseAvailable = true;
      _auth!.authStateChanges().listen(_onAuthStateChanged);
      print('✅ Firebase Auth inicializado correctamente');
    } catch (e) {
      print('❌ Error inicializando Firebase Auth: $e');
      _firebaseAvailable = false;
      _errorMessage = 'Firebase no está disponible';
    }
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
    if (!_firebaseAvailable || _auth == null) {
      _errorMessage = 'Firebase no está disponible';
      return false;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      print('🔐 Intentando iniciar sesión con: $email');

      final credential = await _auth!.signInWithEmailAndPassword(
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
    if (!_firebaseAvailable || _auth == null) {
      _errorMessage = 'Firebase no está disponible';
      return false;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      print('📝 Creando usuario: $email');

      final credential = await _auth!.createUserWithEmailAndPassword(
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
    if (_firestore == null) return;
    
    try {
      final userDoc = _firestore!.collection('users').doc(firebaseUser.uid);
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

  // Enviar email de recuperación de contraseña
  Future<bool> sendPasswordResetEmail(String email) async {
    if (!_firebaseAvailable || _auth == null) {
      _errorMessage = 'Firebase no está disponible';
      return false;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      print('📧 Enviando email de recuperación a: $email');

      await _auth!.sendPasswordResetEmail(email: email);

      print('✅ Email de recuperación enviado correctamente');
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('❌ Error enviando email de recuperación: ${e.code} - ${e.message}');
      _errorMessage = _getPasswordResetErrorMessage(e.code);
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

  Future<void> signOut() async {
    if (!_firebaseAvailable || _auth == null) {
      _currentUser = null;
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      
      print('🚪 Cerrando sesión...');
      await _auth!.signOut();
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

  String _getPasswordResetErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No existe una cuenta con este email';
      case 'invalid-email':
        return 'El email no es válido';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde';
      case 'invalid-recipient-email':
        return 'El email de destino no es válido';
      case 'invalid-sender':
        return 'Error en la configuración del servidor de email';
      case 'invalid-verification-code':
        return 'Código de verificación inválido';
      case 'invalid-verification-id':
        return 'ID de verificación inválido';
      default:
        return 'Error enviando email de recuperación: $errorCode';
    }
  }
}
