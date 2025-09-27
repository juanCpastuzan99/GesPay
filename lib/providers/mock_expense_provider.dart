import 'package:flutter/material.dart';
import '../models/expense.dart';

class MockExpenseProvider extends ChangeNotifier {
  final List<Expense> _expenses = [];
  bool _isLoading = false;

  // Cache para estadísticas
  double? _cachedTotalIncome;
  double? _cachedTotalExpenses;
  double? _cachedBalance;
  int _lastExpensesLength = 0;

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;

  // Estadísticas con cache
  double get totalIncome {
    if (_cachedTotalIncome == null || _expenses.length != _lastExpensesLength) {
      double total = 0.0;
      for (final expense in _expenses) {
        if (expense.amount > 0) {
          total += expense.amount;
        }
      }
      _cachedTotalIncome = total;
      _lastExpensesLength = _expenses.length;
    }
    return _cachedTotalIncome!;
  }

  double get totalExpenses {
    if (_cachedTotalExpenses == null ||
        _expenses.length != _lastExpensesLength) {
      double total = 0.0;
      for (final expense in _expenses) {
        if (expense.amount < 0) {
          total += expense.amount.abs();
        }
      }
      _cachedTotalExpenses = total;
    }
    return _cachedTotalExpenses!;
  }

  double get balance {
    if (_cachedBalance == null || _expenses.length != _lastExpensesLength) {
      _cachedBalance = totalIncome - totalExpenses;
    }
    return _cachedBalance!;
  }

  // Categorías disponibles
  static const List<String> categories = [
    'Alimentación',
    'Transporte',
    'Entretenimiento',
    'Salud',
    'Educación',
    'Ropa',
    'Hogar',
    'Otros',
  ];

  MockExpenseProvider() {
    _loadMockData();
  }

  void _loadMockData() {
    _isLoading = true;
    notifyListeners();

    // Simular carga de datos
    Future.delayed(const Duration(seconds: 1), () {
      _expenses.addAll([
        Expense(
          title: 'Salario',
          amount: 3000.0,
          category: 'Ingresos',
          date: DateTime.now().subtract(const Duration(days: 1)),
          description: 'Salario mensual',
          userId: 'mock_user',
        ),
        Expense(
          title: 'Supermercado',
          amount: -150.0,
          category: 'Alimentación',
          date: DateTime.now().subtract(const Duration(days: 2)),
          description: 'Compra semanal',
          userId: 'mock_user',
        ),
        Expense(
          title: 'Gasolina',
          amount: -80.0,
          category: 'Transporte',
          date: DateTime.now().subtract(const Duration(days: 3)),
          description: 'Llenado de tanque',
          userId: 'mock_user',
        ),
        Expense(
          title: 'Netflix',
          amount: -15.0,
          category: 'Entretenimiento',
          date: DateTime.now().subtract(const Duration(days: 4)),
          description: 'Suscripción mensual',
          userId: 'mock_user',
        ),
      ]);

      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addExpense(Expense expense) async {
    _isLoading = true;
    notifyListeners();

    // Simular operación de red
    await Future.delayed(const Duration(milliseconds: 500));

    _expenses.add(expense);
    _clearCache(); // Limpiar cache
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    _isLoading = true;
    notifyListeners();

    // Simular operación de red
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
      _clearCache(); // Limpiar cache
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteExpense(String expenseId) async {
    _isLoading = true;
    notifyListeners();

    // Simular operación de red
    await Future.delayed(const Duration(milliseconds: 500));

    _expenses.removeWhere((expense) => expense.id == expenseId);
    _clearCache(); // Limpiar cache

    _isLoading = false;
    notifyListeners();
  }

  // Método para limpiar cache
  void _clearCache() {
    _cachedTotalIncome = null;
    _cachedTotalExpenses = null;
    _cachedBalance = null;
  }

  List<Expense> getExpensesByCategory(String category) {
    return _expenses.where((expense) => expense.category == category).toList();
  }

  List<Expense> getExpensesByDateRange(DateTime start, DateTime end) {
    return _expenses.where((expense) {
      return expense.date.isAfter(start) && expense.date.isBefore(end);
    }).toList();
  }
}
