import 'package:flutter/material.dart';
import '../models/user.dart';
import 'simple_auth_provider.dart';

class AuthProvider extends ChangeNotifier {
  final bool firebaseAvailable;
  final SimpleAuthProvider _simpleAuth = SimpleAuthProvider();
  
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider({required this.firebaseAvailable});

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      print('📱 Usando autenticación simple para login');
      
      final success = await _simpleAuth.signIn(email, password);
      if (success) {
        _user = _simpleAuth.user;
      } else {
        _error = _simpleAuth.error;
      }
      return success;
    } catch (e) {
      _error = 'Error inesperado: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String password, String? name) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      print('📱 Usando autenticación simple para registro');
      
      final success = await _simpleAuth.signUp(email, password, name);
      if (success) {
        _user = _simpleAuth.user;
      } else {
        _error = _simpleAuth.error;
      }
      return success;
    } catch (e) {
      _error = 'Error inesperado: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _simpleAuth.signOut();
    _user = null;
    notifyListeners();
  }
}
