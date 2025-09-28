import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aplication/models/expense.dart';

void main() {
  group('Expense Calculations Tests', () {
    late List<Expense> testExpenses;

    setUp(() {
      testExpenses = [
        Expense(
          id: '1',
          title: 'Salary',
          amount: 3000.0, // Income
          category: 'Salary',
          date: DateTime(2024, 1, 1),
          description: 'Monthly salary',
          userId: 'test-user',
        ),
        Expense(
          id: '2',
          title: 'Rent',
          amount: -800.0, // Expense
          category: 'Housing',
          date: DateTime(2024, 1, 2),
          description: 'Monthly rent',
          userId: 'test-user',
        ),
        Expense(
          id: '3',
          title: 'Food',
          amount: -200.0, // Expense
          category: 'Food',
          date: DateTime(2024, 1, 3),
          description: 'Groceries',
          userId: 'test-user',
        ),
        Expense(
          id: '4',
          title: 'Freelance',
          amount: 500.0, // Income
          category: 'Work',
          date: DateTime(2024, 1, 4),
          description: 'Freelance work',
          userId: 'test-user',
        ),
      ];
    });

    test('should calculate total income correctly', () {
      // Act
      final totalIncome = testExpenses
          .where((expense) => expense.amount > 0)
          .fold(0.0, (total, expense) => total + expense.amount);

      // Assert
      expect(totalIncome, 3500.0); // 3000 + 500
    });

    test('should calculate total expenses correctly', () {
      // Act
      final totalExpenses = testExpenses
          .where((expense) => expense.amount < 0)
          .fold(0.0, (total, expense) => total + expense.amount.abs());

      // Assert
      expect(totalExpenses, 1000.0); // 800 + 200
    });

    test('should calculate balance correctly', () {
      // Act
      final balance = testExpenses.fold(0.0, (total, expense) => total + expense.amount);

      // Assert
      expect(balance, 2500.0); // 3500 - 1000
    });

    test('should handle empty expenses list', () {
      // Arrange
      final emptyExpenses = <Expense>[];

      // Act
      final totalIncome = emptyExpenses
          .where((expense) => expense.amount > 0)
          .fold(0.0, (total, expense) => total + expense.amount);
      
      final totalExpenses = emptyExpenses
          .where((expense) => expense.amount < 0)
          .fold(0.0, (total, expense) => total + expense.amount.abs());
      
      final balance = emptyExpenses.fold(0.0, (total, expense) => total + expense.amount);

      // Assert
      expect(totalIncome, 0.0);
      expect(totalExpenses, 0.0);
      expect(balance, 0.0);
    });

    test('should filter expenses by category', () {
      // Act
      final foodExpenses = testExpenses
          .where((expense) => expense.category == 'Food')
          .toList();

      // Assert
      expect(foodExpenses.length, 1);
      expect(foodExpenses.first.title, 'Food');
      expect(foodExpenses.first.amount, -200.0);
    });
  });
}
