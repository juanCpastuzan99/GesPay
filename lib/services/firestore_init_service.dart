import 'package:firebase_auth/firebase_auth.dart';
import '../providers/firestore_expense_provider.dart';

class FirestoreInitService {
  static FirestoreExpenseProvider? _expenseProvider;
  static String? _currentUserId;
  static bool _isInitialized = false;

  // Inicializar el servicio cuando el usuario se autentique
  static void initializeForUser(FirestoreExpenseProvider expenseProvider) {
    _expenseProvider = expenseProvider;

    // Verificar si hay un usuario autenticado
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Si es un usuario diferente, reinicializar
      if (_currentUserId != user.uid) {
        _currentUserId = user.uid;
        _isInitialized = false;
      }
      
      if (!_isInitialized) {
        print('🔄 Inicializando Firestore para usuario: ${user.uid}');
        // Usar carga optimizada en lugar de startListening directo
        _expenseProvider!.loadInitialData();
        _isInitialized = true;
      }
    }
  }

  // Reinicializar cuando cambie el usuario
  static void reinitializeForUser(FirestoreExpenseProvider expenseProvider) {
    _expenseProvider = expenseProvider;
    _currentUserId = null;
    _isInitialized = false;
    initializeForUser(expenseProvider);
  }

  // Limpiar cuando el usuario cierre sesión
  static void clearForUser() {
    _currentUserId = null;
    _isInitialized = false;
    print('🔄 Limpiando datos de sesión anterior');
  }
}
