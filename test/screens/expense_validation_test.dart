import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aplication/models/expense.dart';

void main() {
  group('Expense Validation Tests', () {
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

    test('should validate expense description', () {
      // Arrange
      const validDescriptions = [
        'Weekly groceries',
        'Monthly salary',
        'Gas for car',
        'Dinner with friends',
        'Gym membership fee',
        '', // Empty description should be valid (optional)
        '   ', // Whitespace should be valid (optional)
      ];

      // Act & Assert
      for (final description in validDescriptions) {
        expect(_isValidDescription(description), true, 
               reason: 'Description "$description" should be valid');
      }
    });

    test('should validate expense date', () {
      // Arrange
      final now = DateTime.now();
      final validDates = [
        now,
        now.subtract(const Duration(days: 1)),
        now.subtract(const Duration(days: 30)),
        now.subtract(const Duration(days: 365)),
        DateTime(2024, 1, 1),
        DateTime(2023, 12, 31),
      ];

      final invalidDates = [
        now.add(const Duration(days: 2)), // Future date
        now.add(const Duration(days: 30)), // Future date
      ];

      // Act & Assert
      for (final date in validDates) {
        expect(_isValidDate(date), true, reason: 'Date $date should be valid');
      }

      for (final date in invalidDates) {
        expect(_isValidDate(date), false, reason: 'Date $date should be invalid');
      }
    });

    test('should create valid expense object', () {
      // Arrange
      final expense = Expense(
        id: 'test-expense',
        title: 'Test Expense',
        amount: -100.0,
        category: 'Food',
        date: DateTime.now(),
        description: 'Test description',
        userId: 'test-user',
      );

      // Act & Assert
      expect(expense.id, 'test-expense');
      expect(expense.title, 'Test Expense');
      expect(expense.amount, -100.0);
      expect(expense.category, 'Food');
      expect(expense.description, 'Test description');
      expect(expense.userId, 'test-user');
    });

    test('should create valid income object', () {
      // Arrange
      final income = Expense(
        id: 'test-income',
        title: 'Test Income',
        amount: 1000.0,
        category: 'Salary',
        date: DateTime.now(),
        description: 'Monthly salary',
        userId: 'test-user',
      );

      // Act & Assert
      expect(income.id, 'test-income');
      expect(income.title, 'Test Income');
      expect(income.amount, 1000.0);
      expect(income.category, 'Salary');
      expect(income.description, 'Monthly salary');
      expect(income.userId, 'test-user');
    });

    test('should handle edge cases correctly', () {
      // Arrange
      final edgeCases = [
        Expense(
          id: 'edge-1',
          title: 'A', // Minimum valid title
          amount: 0.01, // Minimum positive amount
          category: 'Other',
          date: DateTime.now(),
          description: '',
          userId: 'user',
        ),
        Expense(
          id: 'edge-2',
          title: 'Very Long Title That Should Still Be Valid',
          amount: -0.01, // Minimum negative amount
          category: 'Other',
          date: DateTime.now(),
          description: 'Very long description that should still be valid',
          userId: 'user',
        ),
      ];

      // Act & Assert
      for (final expense in edgeCases) {
        expect(expense.title.isNotEmpty, true);
        expect(expense.amount != 0.0, true);
        expect(expense.category.isNotEmpty, true);
        expect(expense.userId.isNotEmpty, true);
      }
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

bool _isValidDescription(String description) {
  // Description is optional, so empty or whitespace should be valid
  return true;
}

bool _isValidDate(DateTime date) {
  final now = DateTime.now();
  return date.isBefore(now.add(const Duration(days: 1)));
}
