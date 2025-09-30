import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aplication/models/expense.dart';

void main() {
  group('Expense Model Tests', () {
    test('should create expense from map', () {
      // Arrange
      final map = {
        'id': 'test-id',
        'title': 'Test Expense',
        'amount': 100.0,
        'category': 'Food',
        'date': DateTime(2024, 1, 1),
        'description': 'Test description',
      };

      // Act
      final expense = Expense.fromMap(map);

      // Assert
      expect(expense.id, 'test-id');
      expect(expense.title, 'Test Expense');
      expect(expense.amount, 100.0);
      expect(expense.category, 'Food');
      expect(expense.description, 'Test description');
    });

    test('should convert expense to map', () {
      // Arrange
      final expense = Expense(
        id: 'test-id',
        title: 'Test Expense',
        amount: 100.0,
        category: 'Food',
        date: DateTime(2024, 1, 1),
        description: 'Test description',
        userId: 'test-user-id',
      );

      // Act
      final map = expense.toMap();

      // Assert
      expect(map['id'], 'test-id');
      expect(map['title'], 'Test Expense');
      expect(map['amount'], 100.0);
      expect(map['category'], 'Food');
      expect(map['description'], 'Test description');
    });

    test('should handle null values correctly', () {
      // Arrange
      final map = {
        'id': 'test-id',
        'title': 'Test Expense',
        'amount': 100.0,
        'category': 'Food',
        'date': DateTime(2024, 1, 1),
        'description': null,
      };

      // Act
      final expense = Expense.fromMap(map);

      // Assert
      expect(expense.description, '');
    });
  });
}
