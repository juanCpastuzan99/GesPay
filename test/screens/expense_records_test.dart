import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/expense.dart';

void main() {
  group('Expense Records Tests', () {
    late List<Expense> testExpenses;

    setUp(() {
      testExpenses = [
        Expense(
          id: '1',
          title: 'Comida',
          amount: -50.0, // Gasto
          category: 'Alimentación',
          date: DateTime(2024, 1, 1),
          description: 'Almuerzo en restaurante',
          userId: 'user1',
        ),
        Expense(
          id: '2',
          title: 'Transporte',
          amount: -25.0, // Gasto
          category: 'Transporte',
          date: DateTime(2024, 1, 2),
          description: 'Taxi al trabajo',
          userId: 'user1',
        ),
        Expense(
          id: '3',
          title: 'Cine',
          amount: -15.0, // Gasto
          category: 'Entretenimiento',
          date: DateTime(2024, 1, 3),
          description: 'Película con amigos',
          userId: 'user1',
        ),
      ];
    });

    test('should create expense records correctly', () {
      // Assert
      expect(testExpenses.length, 3);
      expect(testExpenses[0].title, 'Comida');
      expect(testExpenses[0].amount, -50.0);
      expect(testExpenses[0].category, 'Alimentación');
      expect(testExpenses[0].userId, 'user1');
    });

    test('should identify expenses by negative amount', () {
      // Act
      final expenses = testExpenses.where((expense) => expense.amount < 0).toList();

      // Assert
      expect(expenses.length, 3);
      expect(expenses.every((expense) => expense.amount < 0), true);
    });

    test('should calculate total expenses correctly', () {
      // Act
      final totalExpenses = testExpenses
          .where((expense) => expense.amount < 0)
          .fold(0.0, (sum, expense) => sum + expense.amount.abs());

      // Assert
      expect(totalExpenses, 90.0); // 50 + 25 + 15
    });

    test('should filter expenses by category', () {
      // Act
      final foodExpenses = testExpenses
          .where((expense) => expense.category == 'Alimentación')
          .toList();

      // Assert
      expect(foodExpenses.length, 1);
      expect(foodExpenses[0].title, 'Comida');
    });

    test('should filter expenses by date range', () {
      // Arrange
      final startDate = DateTime(2024, 1, 1);
      final endDate = DateTime(2024, 1, 2);

      // Act
      final filteredExpenses = testExpenses
          .where((expense) => 
              expense.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
              expense.date.isBefore(endDate.add(const Duration(days: 1))))
          .toList();

      // Assert
      expect(filteredExpenses.length, 2);
    });

    test('should sort expenses by date descending', () {
      // Act
      final sortedExpenses = List<Expense>.from(testExpenses)
        ..sort((a, b) => b.date.compareTo(a.date));

      // Assert
      expect(sortedExpenses[0].date, DateTime(2024, 1, 3));
      expect(sortedExpenses[1].date, DateTime(2024, 1, 2));
      expect(sortedExpenses[2].date, DateTime(2024, 1, 1));
    });

    test('should sort expenses by amount ascending', () {
      // Act
      final sortedExpenses = List<Expense>.from(testExpenses)
        ..sort((a, b) => a.amount.compareTo(b.amount));

      // Assert
      expect(sortedExpenses[0].amount, -50.0);
      expect(sortedExpenses[1].amount, -25.0);
      expect(sortedExpenses[2].amount, -15.0);
    });

    test('should group expenses by category', () {
      // Act
      final groupedExpenses = <String, List<Expense>>{};
      for (final expense in testExpenses) {
        groupedExpenses.putIfAbsent(expense.category, () => []).add(expense);
      }

      // Assert
      expect(groupedExpenses.keys.length, 3);
      expect(groupedExpenses['Alimentación']!.length, 1);
      expect(groupedExpenses['Transporte']!.length, 1);
      expect(groupedExpenses['Entretenimiento']!.length, 1);
    });

    test('should calculate expenses by category', () {
      // Act
      final categoryTotals = <String, double>{};
      for (final expense in testExpenses) {
        categoryTotals[expense.category] = 
            (categoryTotals[expense.category] ?? 0) + expense.amount.abs();
      }

      // Assert
      expect(categoryTotals['Alimentación'], 50.0);
      expect(categoryTotals['Transporte'], 25.0);
      expect(categoryTotals['Entretenimiento'], 15.0);
    });

    test('should validate expense data integrity', () {
      // Act & Assert
      for (final expense in testExpenses) {
        expect(expense.id.isNotEmpty, true);
        expect(expense.title.isNotEmpty, true);
        expect(expense.amount, isNot(0));
        expect(expense.category.isNotEmpty, true);
        expect(expense.userId.isNotEmpty, true);
        expect(expense.date, isA<DateTime>());
      }
    });

    test('should handle empty expense list', () {
      // Arrange
      final emptyExpenses = <Expense>[];

      // Act
      final totalExpenses = emptyExpenses
          .where((expense) => expense.amount < 0)
          .fold(0.0, (sum, expense) => sum + expense.amount.abs());

      // Assert
      expect(totalExpenses, 0.0);
    });

    test('should filter expenses by user', () {
      // Act
      final userExpenses = testExpenses
          .where((expense) => expense.userId == 'user1')
          .toList();

      // Assert
      expect(userExpenses.length, 3);
      expect(userExpenses.every((expense) => expense.userId == 'user1'), true);
    });
  });
}
