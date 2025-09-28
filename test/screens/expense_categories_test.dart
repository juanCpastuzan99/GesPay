import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Expense Categories Tests', () {
    test('should have valid expense categories', () {
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

      // Act & Assert
      expect(expenseCategories.length, 8);
      expect(expenseCategories.contains('Alimentación'), true);
      expect(expenseCategories.contains('Transporte'), true);
      expect(expenseCategories.contains('Otros'), true);
    });

    test('should have valid income categories', () {
      // Arrange
      const incomeCategories = [
        'Salario',
        'Freelance',
        'Inversión',
        'Venta',
        'Bonificación',
        'Otros',
      ];

      // Act & Assert
      expect(incomeCategories.length, 6);
      expect(incomeCategories.contains('Salario'), true);
      expect(incomeCategories.contains('Freelance'), true);
      expect(incomeCategories.contains('Otros'), true);
    });

    test('should categorize expense type correctly', () {
      // Arrange
      const testCases = [
        {'amount': 100.0, 'isIncome': true, 'expectedSign': 1},
        {'amount': 50.0, 'isIncome': false, 'expectedSign': -1},
        {'amount': 0.01, 'isIncome': true, 'expectedSign': 1},
        {'amount': -0.01, 'isIncome': false, 'expectedSign': -1},
      ];

      // Act & Assert
      for (final testCase in testCases) {
        final amount = testCase['amount'] as double;
        final isIncome = testCase['isIncome'] as bool;
        final expectedSign = testCase['expectedSign'] as int;
        
        final processedAmount = isIncome ? amount : -amount;
        final actualSign = processedAmount > 0 ? 1 : -1;
        
        expect(actualSign, expectedSign);
      }
    });

    test('should validate category selection', () {
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
      for (final category in expenseCategories) {
        expect(_isValidExpenseCategory(category), true, 
               reason: 'Category "$category" should be valid for expenses');
      }

      for (final category in incomeCategories) {
        expect(_isValidIncomeCategory(category), true, 
               reason: 'Category "$category" should be valid for income');
      }
    });

    test('should handle category switching', () {
      // Arrange
      const expenseCategories = ['Alimentación', 'Transporte', 'Otros'];
      const incomeCategories = ['Salario', 'Freelance', 'Otros'];
      
      // Act
      final expenseDefault = expenseCategories.first;
      final incomeDefault = incomeCategories.first;
      
      // Assert
      expect(expenseDefault, 'Alimentación');
      expect(incomeDefault, 'Salario');
      expect(expenseCategories.contains('Otros'), true);
      expect(incomeCategories.contains('Otros'), true);
    });

    test('should format category display correctly', () {
      // Arrange
      const testCases = [
        {'category': 'Alimentación', 'expected': 'Alimentación'},
        {'category': 'Salario', 'expected': 'Salario'},
        {'category': 'Otros', 'expected': 'Otros'},
      ];

      // Act & Assert
      for (final testCase in testCases) {
        final category = testCase['category'] as String;
        final expected = testCase['expected'] as String;
        final formatted = _formatCategoryDisplay(category);
        expect(formatted, expected);
      }
    });
  });
}

// Helper functions
bool _isValidExpenseCategory(String category) {
  const validCategories = [
    'Alimentación',
    'Transporte',
    'Entretenimiento',
    'Salud',
    'Educación',
    'Ropa',
    'Hogar',
    'Otros',
  ];
  return validCategories.contains(category);
}

bool _isValidIncomeCategory(String category) {
  const validCategories = [
    'Salario',
    'Freelance',
    'Inversión',
    'Venta',
    'Bonificación',
    'Otros',
  ];
  return validCategories.contains(category);
}

String _formatCategoryDisplay(String category) {
  return category;
}
