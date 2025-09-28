import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/expense.dart';

void main() {
  group('Income Records Tests', () {
    late List<Expense> testIncomes;

    setUp(() {
      testIncomes = [
        Expense(
          id: '1',
          title: 'Salario',
          amount: 3000.0, // Ingreso
          category: 'Salario',
          date: DateTime(2024, 1, 1),
          description: 'Salario mensual',
          userId: 'user1',
        ),
        Expense(
          id: '2',
          title: 'Freelance',
          amount: 500.0, // Ingreso
          category: 'Freelance',
          date: DateTime(2024, 1, 5),
          description: 'Proyecto de desarrollo web',
          userId: 'user1',
        ),
        Expense(
          id: '3',
          title: 'Venta',
          amount: 200.0, // Ingreso
          category: 'Venta',
          date: DateTime(2024, 1, 10),
          description: 'Venta de productos usados',
          userId: 'user1',
        ),
        Expense(
          id: '4',
          title: 'Inversión',
          amount: 150.0, // Ingreso
          category: 'Inversión',
          date: DateTime(2024, 1, 15),
          description: 'Dividendos de acciones',
          userId: 'user1',
        ),
      ];
    });

    test('should create income records correctly', () {
      // Assert
      expect(testIncomes.length, 4);
      expect(testIncomes[0].title, 'Salario');
      expect(testIncomes[0].amount, 3000.0);
      expect(testIncomes[0].category, 'Salario');
      expect(testIncomes[0].userId, 'user1');
    });

    test('should identify incomes by positive amount', () {
      // Act
      final incomes = testIncomes.where((income) => income.amount > 0).toList();

      // Assert
      expect(incomes.length, 4);
      expect(incomes.every((income) => income.amount > 0), true);
    });

    test('should calculate total income correctly', () {
      // Act
      final totalIncome = testIncomes
          .where((income) => income.amount > 0)
          .fold(0.0, (sum, income) => sum + income.amount);

      // Assert
      expect(totalIncome, 3850.0); // 3000 + 500 + 200 + 150
    });

    test('should filter incomes by category', () {
      // Act
      final salaryIncomes = testIncomes
          .where((income) => income.category == 'Salario')
          .toList();

      // Assert
      expect(salaryIncomes.length, 1);
      expect(salaryIncomes[0].title, 'Salario');
      expect(salaryIncomes[0].amount, 3000.0);
    });

    test('should filter incomes by date range', () {
      // Arrange
      final startDate = DateTime(2024, 1, 1);
      final endDate = DateTime(2024, 1, 10);

      // Act
      final filteredIncomes = testIncomes
          .where(
            (income) =>
                income.date.isAfter(
                  startDate.subtract(const Duration(days: 1)),
                ) &&
                income.date.isBefore(endDate.add(const Duration(days: 1))),
          )
          .toList();

      // Assert
      expect(filteredIncomes.length, 3);
    });

    test('should sort incomes by date descending', () {
      // Act
      final sortedIncomes = List<Expense>.from(testIncomes)
        ..sort((a, b) => b.date.compareTo(a.date));

      // Assert
      expect(sortedIncomes[0].date, DateTime(2024, 1, 15));
      expect(sortedIncomes[1].date, DateTime(2024, 1, 10));
      expect(sortedIncomes[2].date, DateTime(2024, 1, 5));
      expect(sortedIncomes[3].date, DateTime(2024, 1, 1));
    });

    test('should sort incomes by amount descending', () {
      // Act
      final sortedIncomes = List<Expense>.from(testIncomes)
        ..sort((a, b) => b.amount.compareTo(a.amount));

      // Assert
      expect(sortedIncomes[0].amount, 3000.0);
      expect(sortedIncomes[1].amount, 500.0);
      expect(sortedIncomes[2].amount, 200.0);
      expect(sortedIncomes[3].amount, 150.0);
    });

    test('should group incomes by category', () {
      // Act
      final groupedIncomes = <String, List<Expense>>{};
      for (final income in testIncomes) {
        groupedIncomes.putIfAbsent(income.category, () => []).add(income);
      }

      // Assert
      expect(groupedIncomes.keys.length, 4);
      expect(groupedIncomes['Salario']!.length, 1);
      expect(groupedIncomes['Freelance']!.length, 1);
      expect(groupedIncomes['Venta']!.length, 1);
      expect(groupedIncomes['Inversión']!.length, 1);
    });

    test('should calculate incomes by category', () {
      // Act
      final categoryTotals = <String, double>{};
      for (final income in testIncomes) {
        categoryTotals[income.category] =
            (categoryTotals[income.category] ?? 0) + income.amount;
      }

      // Assert
      expect(categoryTotals['Salario'], 3000.0);
      expect(categoryTotals['Freelance'], 500.0);
      expect(categoryTotals['Venta'], 200.0);
      expect(categoryTotals['Inversión'], 150.0);
    });

    test('should validate income data integrity', () {
      // Act & Assert
      for (final income in testIncomes) {
        expect(income.id.isNotEmpty, true);
        expect(income.title.isNotEmpty, true);
        expect(income.amount, greaterThan(0));
        expect(income.category.isNotEmpty, true);
        expect(income.userId.isNotEmpty, true);
        expect(income.date, isA<DateTime>());
      }
    });

    test('should handle empty income list', () {
      // Arrange
      final emptyIncomes = <Expense>[];

      // Act
      final totalIncome = emptyIncomes
          .where((income) => income.amount > 0)
          .fold(0.0, (sum, income) => sum + income.amount);

      // Assert
      expect(totalIncome, 0.0);
    });

    test('should filter incomes by user', () {
      // Act
      final userIncomes = testIncomes
          .where((income) => income.userId == 'user1')
          .toList();

      // Assert
      expect(userIncomes.length, 4);
      expect(userIncomes.every((income) => income.userId == 'user1'), true);
    });

    test('should calculate monthly income', () {
      // Arrange
      final monthlyIncomes = testIncomes
          .where((income) => income.date.month == 1 && income.date.year == 2024)
          .toList();

      // Act
      final monthlyTotal = monthlyIncomes.fold(
        0.0,
        (sum, income) => sum + income.amount,
      );

      // Assert
      expect(monthlyTotal, 3850.0);
    });

    test('should find highest income', () {
      // Act
      final highestIncome = testIncomes.reduce(
        (a, b) => a.amount > b.amount ? a : b,
      );

      // Assert
      expect(highestIncome.title, 'Salario');
      expect(highestIncome.amount, 3000.0);
    });

    test('should find lowest income', () {
      // Act
      final lowestIncome = testIncomes.reduce(
        (a, b) => a.amount < b.amount ? a : b,
      );

      // Assert
      expect(lowestIncome.title, 'Inversión');
      expect(lowestIncome.amount, 150.0);
    });
  });
}
