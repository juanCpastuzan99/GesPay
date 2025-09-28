import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aplication/models/expense.dart';

void main() {
  group('Simple Add Expense Tests', () {
    test('should validate expense title correctly', () {
      // Arrange
      const validTitles = [
        'Groceries',
        'Gas Station',
        'Restaurant',
        'Salary',
        'Freelance Work',
        'Monthly Rent',
        'Gym Membership',
      ];

      const invalidTitles = [
        '',
        '   ',
      ];

      // Act & Assert
      for (final title in validTitles) {
        expect(_isValidTitle(title), true, reason: 'Title "$title" should be valid');
      }

      for (final title in invalidTitles) {
        expect(_isValidTitle(title), false, reason: 'Title "$title" should be invalid');
      }
    });

    test('should validate expense amount correctly', () {
      // Arrange
      const validAmounts = [
        0.01,
        1.0,
        100.0,
        999.99,
        1000.0,
        -0.01,
        -1.0,
        -100.0,
        -999.99,
        -1000.0,
      ];

      const invalidAmounts = [
        0.0,
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ];

      // Act & Assert
      for (final amount in validAmounts) {
        expect(_isValidAmount(amount), true, reason: 'Amount $amount should be valid');
      }

      for (final amount in invalidAmounts) {
        expect(_isValidAmount(amount), false, reason: 'Amount $amount should be invalid');
      }
    });

    test('should create expense with positive amount (income)', () {
      // Arrange
      final expense = Expense(
        id: 'test-income',
        title: 'Salary',
        amount: 3000.0,
        category: 'Work',
        date: DateTime.now(),
        description: 'Monthly salary',
        userId: 'test-user',
      );

      // Act
      final isIncome = expense.amount > 0;
      final isExpense = expense.amount < 0;

      // Assert
      expect(isIncome, true);
      expect(isExpense, false);
      expect(expense.title, 'Salary');
      expect(expense.category, 'Work');
    });

    test('should create expense with negative amount (expense)', () {
      // Arrange
      final expense = Expense(
        id: 'test-expense',
        title: 'Groceries',
        amount: -150.0,
        category: 'Food',
        date: DateTime.now(),
        description: 'Weekly groceries',
        userId: 'test-user',
      );

      // Act
      final isIncome = expense.amount > 0;
      final isExpense = expense.amount < 0;

      // Assert
      expect(isIncome, false);
      expect(isExpense, true);
      expect(expense.title, 'Groceries');
      expect(expense.category, 'Food');
    });

    test('should format amount correctly for display', () {
      // Arrange
      const testCases = [
        {'amount': 100.0, 'expected': '100.00'},
        {'amount': -50.0, 'expected': '-50.00'},
        {'amount': 0.01, 'expected': '0.01'},
        {'amount': 1234.56, 'expected': '1234.56'},
      ];

      // Act & Assert
      for (final testCase in testCases) {
        final amount = testCase['amount'] as double;
        final expected = testCase['expected'] as String;
        final formatted = _formatAmount(amount);
        expect(formatted, expected);
      }
    });

    test('should categorize expense type correctly', () {
      // Arrange
      const testCases = [
        {'amount': 100.0, 'expectedType': 'Income'},
        {'amount': -50.0, 'expectedType': 'Expense'},
        {'amount': 0.01, 'expectedType': 'Income'},
        {'amount': -0.01, 'expectedType': 'Expense'},
      ];

      // Act & Assert
      for (final testCase in testCases) {
        final amount = testCase['amount'] as double;
        final expectedType = testCase['expectedType'] as String;
        final actualType = _getExpenseType(amount);
        expect(actualType, expectedType);
      }
    });

    test('should handle expense categories correctly', () {
      // Arrange
      const expenseCategories = [
        'Alimentación',
        'Transporte',
        'Entretenimiento',
        'Salud',
        'Educación',
        'Ropa',
        'Hogar',
        'Otros',
      ];

      const incomeCategories = [
        'Salario',
        'Freelance',
        'Inversión',
        'Venta',
        'Bonificación',
        'Otros',
      ];

      // Act & Assert
      expect(expenseCategories.length, 8);
      expect(incomeCategories.length, 6);
      expect(expenseCategories.contains('Alimentación'), true);
      expect(incomeCategories.contains('Salario'), true);
      expect(expenseCategories.contains('Otros'), true);
      expect(incomeCategories.contains('Otros'), true);
    });
  });
}

// Helper functions for validation
bool _isValidTitle(String title) {
  return title.trim().isNotEmpty && title.trim().length >= 1;
}

bool _isValidAmount(double amount) {
  return amount != 0.0 && !amount.isNaN && !amount.isInfinite;
}

String _formatAmount(double amount) {
  return amount.toStringAsFixed(2);
}

String _getExpenseType(double amount) {
  return amount > 0 ? 'Income' : 'Expense';
}
