import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'simple_auth_provider.dart';
import '../models/user.dart';

class HybridAuthProvider extends ChangeNotifier {
  final bool firebaseAvailable;
  late final SimpleAuthProvider _fallbackAuth;
  firebase_auth.FirebaseAuth? _firebaseAuth;
  FirebaseFirestore? _firestore;

  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  HybridAuthProvider({required this.firebaseAvailable}) {
    _fallbackAuth = SimpleAuthProvider();
    _fallbackAuth.addListener(_onFallbackAuthChanged);

    if (firebaseAvailable) {
      try {
        _firebaseAuth = firebase_auth.FirebaseAuth.instance;
        _firestore = FirebaseFirestore.instance;
        _listenToAuthChanges();
      } catch (e) {
        debugPrint('Error inicializando Firebase: $e');
      }
    }
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get error => _errorMessage;
  User? get currentUser => _currentUser;
  User? get user => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  void _onFallbackAuthChanged() {
    if (!firebaseAvailable || _firebaseAuth == null) {
      _currentUser = _fallbackAuth.user;
      notifyListeners();
    }
  }

  void _listenToAuthChanges() {
    if (_firebaseAuth != null) {
      _firebaseAuth!.authStateChanges().listen((firebase_auth.User? user) {
        if (user != null) {
          _loadUserFromFirebase(user);
        } else {
          _currentUser = null;
          notifyListeners();
        }
      });
    }
  }

  Future<void> _loadUserFromFirebase(firebase_auth.User firebaseUser) async {
    try {
      if (_firestore != null) {
        final doc = await _firestore!
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        if (doc.exists) {
          final data = doc.data()!;
          _currentUser = User(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: data['name'] ?? '',
            createdAt:
                (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          );
        } else {
          // Crear usuario en Firestore si no existe
          _currentUser = User(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: firebaseUser.displayName ?? '',
            createdAt: DateTime.now(),
          );
          await _firestore!.collection('users').doc(firebaseUser.uid).set({
            'name': _currentUser!.name,
            'email': _currentUser!.email,
            'createdAt': Timestamp.fromDate(
              _currentUser!.createdAt ?? DateTime.now(),
            ),
          });
        }
      }
    } catch (e) {
      debugPrint('Error cargando usuario de Firebase: $e');
    }
    notifyListeners();
  }

  Future<bool> signUp(String email, String password, String name) async {
    _setLoading(true);
    _clearError();

    try {
      if (firebaseAvailable && _firebaseAuth != null) {
        // Usar Firebase
        final credential = await _firebaseAuth!.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (credential.user != null) {
          await credential.user!.updateDisplayName(name);

          if (_firestore != null) {
            await _firestore!
                .collection('users')
                .doc(credential.user!.uid)
                .set({
                  'name': name,
                  'email': email,
                  'createdAt': Timestamp.fromDate(DateTime.now()),
                });
          }

          _currentUser = User(
            id: credential.user!.uid,
            email: email,
            name: name,
            createdAt: DateTime.now(),
          );

          _setLoading(false);
          return true;
        }
      } else {
        // Usar autenticación simple como fallback
        return await _fallbackAuth.signUp(email, password, name);
      }
    } catch (e) {
      _setError('Error al registrar usuario: ${e.toString()}');
      _setLoading(false);
      return false;
    }

    _setLoading(false);
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      if (firebaseAvailable && _firebaseAuth != null) {
        // Usar Firebase
        final credential = await _firebaseAuth!.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (credential.user != null) {
          _setLoading(false);
          return true;
        }
      } else {
        // Usar autenticación simple como fallback
        return await _fallbackAuth.signIn(email, password);
      }
    } catch (e) {
      _setError('Error al iniciar sesión: ${e.toString()}');
      _setLoading(false);
      return false;
    }

    _setLoading(false);
    return false;
  }

  Future<void> signOut() async {
    _setLoading(true);

    try {
      if (firebaseAvailable && _firebaseAuth != null) {
        await _firebaseAuth!.signOut();
      } else {
        await _fallbackAuth.signOut();
      }

      _currentUser = null;
    } catch (e) {
      _setError('Error al cerrar sesión: ${e.toString()}');
    }

    _setLoading(false);
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _fallbackAuth.removeListener(_onFallbackAuthChanged);
    super.dispose();
  }
}
