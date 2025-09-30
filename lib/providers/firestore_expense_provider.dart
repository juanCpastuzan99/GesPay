import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../models/expense.dart';

class FirestoreExpenseProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Expense> _expenses = [];
  bool _isLoading = false;
  bool _isInitialLoad = true;
  String? _error;
  StreamSubscription<QuerySnapshot>? _expensesSubscription;
  DateTime? _lastFetchTime;
  static const Duration _cacheTimeout = Duration(minutes: 5);

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;
  bool get isInitialLoad => _isInitialLoad;
  String? get error => _error;
  bool get hasData => _expenses.isNotEmpty;
  bool get isCacheValid =>
      _lastFetchTime != null &&
      DateTime.now().difference(_lastFetchTime!) < _cacheTimeout;

  // Calcular total de ingresos
  double get totalIncome {
    return _expenses
        .where((expense) => expense.amount > 0)
        .fold(0.0, (total, expense) => total + expense.amount);
  }

  // Calcular total de gastos
  double get totalExpenses {
    return _expenses
        .where((expense) => expense.amount < 0)
        .fold(0.0, (total, expense) => total + expense.amount);
  }

  // Calcular balance
  double get balance {
    return _expenses.fold(0.0, (total, expense) => total + expense.amount);
  }

  // Obtener el ID del usuario actual
  String? get _currentUserId => _auth.currentUser?.uid;

  // Escuchar cambios en los gastos del usuario actual
  void startListening() {
    if (_currentUserId == null) {
      print('❌ No hay usuario autenticado para escuchar gastos');
      return;
    }

    // Cancelar suscripción anterior si existe
    _expensesSubscription?.cancel();

    print('🔍 Iniciando listener para usuario: $_currentUserId');

    // Si tenemos caché válido, mostrarlo inmediatamente
    if (isCacheValid && hasData) {
      print('⚡ Mostrando datos del caché');
      _isInitialLoad = false;
      notifyListeners();
    } else {
      _isLoading = true;
      _isInitialLoad = true;
      notifyListeners();
    }

    _expensesSubscription = _firestore
        .collection('expenses')
        .where('userId', isEqualTo: _currentUserId)
        .orderBy('date', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            print('📊 Datos recibidos: ${snapshot.docs.length} gastos');
            _expenses = snapshot.docs.map((doc) {
              final data = doc.data();
              return Expense.fromMap({...data, 'id': doc.id});
            }).toList();
            _error = null;
            _isLoading = false;
            _isInitialLoad = false;
            _lastFetchTime = DateTime.now();
            notifyListeners();
          },
          onError: (error) {
            print('❌ Error en listener de Firestore: $error');
            _error = error.toString();
            _isLoading = false;
            _isInitialLoad = false;
            notifyListeners();
          },
        );
  }

  // Agregar un nuevo gasto
  Future<bool> addExpense(Expense expense) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      if (_currentUserId == null) {
        _error = 'Usuario no autenticado';
        return false;
      }

      // Crear el documento en Firestore
      await _firestore.collection('expenses').add({
        'title': expense.title,
        'amount': expense.amount,
        'category': expense.category,
        'date': Timestamp.fromDate(expense.date),
        'description': expense.description,
        'userId': _currentUserId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('✅ Gasto agregado a Firestore correctamente');
      return true;
    } catch (e) {
      print('❌ Error agregando gasto: $e');
      _error = 'Error al agregar gasto: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Actualizar un gasto existente
  Future<bool> updateExpense(String expenseId, Expense updatedExpense) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      if (_currentUserId == null) {
        _error = 'Usuario no autenticado';
        return false;
      }

      await _firestore.collection('expenses').doc(expenseId).update({
        'title': updatedExpense.title,
        'amount': updatedExpense.amount,
        'category': updatedExpense.category,
        'date': Timestamp.fromDate(updatedExpense.date),
        'description': updatedExpense.description,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('✅ Gasto actualizado en Firestore correctamente');
      return true;
    } catch (e) {
      print('❌ Error actualizando gasto: $e');
      _error = 'Error al actualizar gasto: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Eliminar un gasto
  Future<bool> deleteExpense(String expenseId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      if (_currentUserId == null) {
        _error = 'Usuario no autenticado';
        return false;
      }

      await _firestore.collection('expenses').doc(expenseId).delete();

      print('✅ Gasto eliminado de Firestore correctamente');
      return true;
    } catch (e) {
      print('❌ Error eliminando gasto: $e');
      _error = 'Error al eliminar gasto: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Obtener gastos por rango de fechas
  Future<List<Expense>> getExpensesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      if (_currentUserId == null) return [];

      final querySnapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: _currentUserId)
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Expense.fromMap({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('❌ Error obteniendo gastos por fecha: $e');
      return [];
    }
  }

  // Obtener gastos por categoría
  Future<List<Expense>> getExpensesByCategory(String category) async {
    try {
      if (_currentUserId == null) return [];

      final querySnapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: _currentUserId)
          .where('category', isEqualTo: category)
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Expense.fromMap({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('❌ Error obteniendo gastos por categoría: $e');
      return [];
    }
  }

  // Obtener estadísticas del usuario
  Future<Map<String, dynamic>> getUserStats() async {
    try {
      if (_currentUserId == null) return {};

      final querySnapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: _currentUserId)
          .get();

      double totalExpenses = 0;
      Map<String, double> categoryTotals = {};
      int totalCount = querySnapshot.docs.length;

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final amount = (data['amount'] ?? 0.0).toDouble();
        final category = data['category'] ?? 'Otros';

        totalExpenses += amount;
        categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
      }

      return {
        'totalExpenses': totalExpenses,
        'totalCount': totalCount,
        'categoryTotals': categoryTotals,
        'averageExpense': totalCount > 0 ? totalExpenses / totalCount : 0,
      };
    } catch (e) {
      print('❌ Error obteniendo estadísticas: $e');
      return {};
    }
  }

  // Cargar datos iniciales de forma optimizada
  Future<void> loadInitialData() async {
    if (_currentUserId == null) return;

    try {
      _isLoading = true;
      _isInitialLoad = true;
      notifyListeners();

      print('⚡ Cargando datos iniciales...');

      // Cargar solo los últimos 10 gastos para mostrar algo rápido
      final querySnapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: _currentUserId)
          .orderBy('date', descending: true)
          .limit(10)
          .get();

      _expenses = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Expense.fromMap({...data, 'id': doc.id});
      }).toList();

      _error = null;
      _isLoading = false;
      _isInitialLoad = false;
      _lastFetchTime = DateTime.now();
      notifyListeners();

      print('✅ Datos iniciales cargados: ${_expenses.length} gastos');

      // Ahora iniciar el listener para actualizaciones en tiempo real
      startListening();
    } catch (e) {
      print('❌ Error cargando datos iniciales: $e');
      _error = 'Error cargando datos: $e';
      _isLoading = false;
      _isInitialLoad = false;
      notifyListeners();
    }
  }

  // No limpiar datos - se mantienen en Firestore para cada usuario
  void clearData() {
    // Los datos se mantienen en Firestore para cada usuario
    // Solo se actualiza la interfaz cuando el usuario cambia
    print('🔄 Datos se mantienen en Firestore para cada usuario');
  }

  @override
  void dispose() {
    _expensesSubscription?.cancel();
    super.dispose();
  }
}
