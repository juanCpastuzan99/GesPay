import 'package:flutter/material.dart';
import '../models/user.dart';

class SimpleAuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      print('📱 Usando SimpleAuthProvider para login');
      
      // Simular autenticación simple
      await Future.delayed(const Duration(seconds: 1));
      
      if (email == 'test@test.com' && password == '123456') {
        _user = User(
          id: 'simple_user_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          name: 'Usuario de Prueba',
          createdAt: DateTime.now(),
        );
        return true;
      } else {
        _error = 'Credenciales incorrectas';
        return false;
      }
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

      print('📱 Usando SimpleAuthProvider para registro');
      
      // Simular registro simple
      await Future.delayed(const Duration(seconds: 1));
      
      if (email == 'test@test.com') {
        _error = 'Este email ya está registrado';
        return false;
      }
      
      _user = User(
        id: 'simple_user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name ?? 'Usuario',
        createdAt: DateTime.now(),
      );
      return true;
    } catch (e) {
      _error = 'Error inesperado: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }
}
