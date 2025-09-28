import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/expense.dart';

void main() {
  group('Expense Calculations Tests', () {
    late List<Expense> testTransactions;

    setUp(() {
      testTransactions = [
        // Ingresos
        Expense(
          id: '1',
          title: 'Salario',
          amount: 3000.0,
          category: 'Salario',
          date: DateTime(2024, 1, 1),
          description: 'Salario mensual',
          userId: 'user1',
        ),
        Expense(
          id: '2',
          title: 'Freelance',
          amount: 500.0,
          category: 'Freelance',
          date: DateTime(2024, 1, 5),
          description: 'Proyecto web',
          userId: 'user1',
        ),
        // Gastos
        Expense(
          id: '3',
          title: 'Comida',
          amount: -200.0,
          category: 'Alimentación',
          date: DateTime(2024, 1, 2),
          description: 'Supermercado',
          userId: 'user1',
        ),
        Expense(
          id: '4',
          title: 'Transporte',
          amount: -100.0,
          category: 'Transporte',
          date: DateTime(2024, 1, 3),
          description: 'Gasolina',
          userId: 'user1',
        ),
        Expense(
          id: '5',
          title: 'Entretenimiento',
          amount: -50.0,
          category: 'Entretenimiento',
          date: DateTime(2024, 1, 4),
          description: 'Cine',
          userId: 'user1',
        ),
      ];
    });

    test('should calculate total income correctly', () {
      // Act
      final totalIncome = testTransactions
          .where((transaction) => transaction.amount > 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount);

      // Assert
      expect(totalIncome, 3500.0); // 3000 + 500
    });

    test('should calculate total expenses correctly', () {
      // Act
      final totalExpenses = testTransactions
          .where((transaction) => transaction.amount < 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount.abs());

      // Assert
      expect(totalExpenses, 350.0); // 200 + 100 + 50
    });

    test('should calculate balance correctly', () {
      // Act
      final totalIncome = testTransactions
          .where((transaction) => transaction.amount > 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount);

      final totalExpenses = testTransactions
          .where((transaction) => transaction.amount < 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount.abs());

      final balance = totalIncome - totalExpenses;

      // Assert
      expect(balance, 3150.0); // 3500 - 350
    });

    test('should calculate expenses by category', () {
      // Act
      final expensesByCategory = <String, double>{};
      for (final transaction in testTransactions) {
        if (transaction.amount < 0) {
          expensesByCategory[transaction.category] =
              (expensesByCategory[transaction.category] ?? 0) +
              transaction.amount.abs();
        }
      }

      // Assert
      expect(expensesByCategory['Alimentación'], 200.0);
      expect(expensesByCategory['Transporte'], 100.0);
      expect(expensesByCategory['Entretenimiento'], 50.0);
    });

    test('should calculate income by category', () {
      // Act
      final incomeByCategory = <String, double>{};
      for (final transaction in testTransactions) {
        if (transaction.amount > 0) {
          incomeByCategory[transaction.category] =
              (incomeByCategory[transaction.category] ?? 0) +
              transaction.amount;
        }
      }

      // Assert
      expect(incomeByCategory['Salario'], 3000.0);
      expect(incomeByCategory['Freelance'], 500.0);
    });

    test('should calculate monthly totals', () {
      // Act
      final monthlyIncome = testTransactions
          .where(
            (transaction) =>
                transaction.amount > 0 &&
                transaction.date.month == 1 &&
                transaction.date.year == 2024,
          )
          .fold(0.0, (sum, transaction) => sum + transaction.amount);

      final monthlyExpenses = testTransactions
          .where(
            (transaction) =>
                transaction.amount < 0 &&
                transaction.date.month == 1 &&
                transaction.date.year == 2024,
          )
          .fold(0.0, (sum, transaction) => sum + transaction.amount.abs());

      // Assert
      expect(monthlyIncome, 3500.0);
      expect(monthlyExpenses, 350.0);
    });

    test('should calculate average transaction amount', () {
      // Act
      final totalAmount = testTransactions.fold(
        0.0,
        (sum, transaction) => sum + transaction.amount.abs(),
      );
      final averageAmount = totalAmount / testTransactions.length;

      // Assert
      expect(averageAmount, 770.0); // (3000 + 500 + 200 + 100 + 50) / 5
    });

    test('should find highest expense', () {
      // Act
      final highestExpense = testTransactions
          .where((transaction) => transaction.amount < 0)
          .reduce((a, b) => a.amount.abs() > b.amount.abs() ? a : b);

      // Assert
      expect(highestExpense.title, 'Comida');
      expect(highestExpense.amount, -200.0);
    });

    test('should find highest income', () {
      // Act
      final highestIncome = testTransactions
          .where((transaction) => transaction.amount > 0)
          .reduce((a, b) => a.amount > b.amount ? a : b);

      // Assert
      expect(highestIncome.title, 'Salario');
      expect(highestIncome.amount, 3000.0);
    });

    test('should calculate expense percentage by category', () {
      // Arrange
      final totalExpenses = testTransactions
          .where((transaction) => transaction.amount < 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount.abs());

      // Act
      final expensesByCategory = <String, double>{};
      for (final transaction in testTransactions) {
        if (transaction.amount < 0) {
          expensesByCategory[transaction.category] =
              (expensesByCategory[transaction.category] ?? 0) +
              transaction.amount.abs();
        }
      }

      final percentages = <String, double>{};
      expensesByCategory.forEach((category, amount) {
        percentages[category] = (amount / totalExpenses) * 100;
      });

      // Assert
      expect(
        percentages['Alimentación'],
        closeTo(57.14, 0.01),
      ); // 200/350 * 100
      expect(percentages['Transporte'], closeTo(28.57, 0.01)); // 100/350 * 100
      expect(
        percentages['Entretenimiento'],
        closeTo(14.29, 0.01),
      ); // 50/350 * 100
    });

    test('should calculate savings rate', () {
      // Act
      final totalIncome = testTransactions
          .where((transaction) => transaction.amount > 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount);

      final totalExpenses = testTransactions
          .where((transaction) => transaction.amount < 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount.abs());

      final savings = totalIncome - totalExpenses;
      final savingsRate = (savings / totalIncome) * 100;

      // Assert
      expect(savingsRate, closeTo(90.0, 0.01)); // (3150/3500) * 100
    });

    test('should handle empty transaction list', () {
      // Arrange
      final emptyTransactions = <Expense>[];

      // Act
      final totalIncome = emptyTransactions
          .where((transaction) => transaction.amount > 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount);

      final totalExpenses = emptyTransactions
          .where((transaction) => transaction.amount < 0)
          .fold(0.0, (sum, transaction) => sum + transaction.amount.abs());

      // Assert
      expect(totalIncome, 0.0);
      expect(totalExpenses, 0.0);
    });

    test('should calculate daily average expenses', () {
      // Arrange
      final expenses = testTransactions
          .where((transaction) => transaction.amount < 0)
          .toList();

      final firstDate = expenses
          .map((e) => e.date)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      final lastDate = expenses
          .map((e) => e.date)
          .reduce((a, b) => a.isAfter(b) ? a : b);
      final daysDifference = lastDate.difference(firstDate).inDays + 1;

      // Act
      final totalExpenses = expenses.fold(
        0.0,
        (sum, transaction) => sum + transaction.amount.abs(),
      );
      final dailyAverage = totalExpenses / daysDifference;

      // Assert
      expect(dailyAverage, closeTo(116.67, 0.01)); // 350 / 3 days
    });

    test('should filter transactions by date range', () {
      // Arrange
      final startDate = DateTime(2024, 1, 1);
      final endDate = DateTime(2024, 1, 3);

      // Act
      final filteredTransactions = testTransactions
          .where(
            (transaction) =>
                transaction.date.isAfter(
                  startDate.subtract(const Duration(days: 1)),
                ) &&
                transaction.date.isBefore(endDate.add(const Duration(days: 1))),
          )
          .toList();

      // Assert
      expect(filteredTransactions.length, 3);
    });
  });
}
