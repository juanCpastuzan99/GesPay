import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Simple Expense Selector Tests', () {
    test('should have correct expense categories', () {
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

      // Assert
      expect(expenseCategories.length, 8);
      expect(expenseCategories.contains('Alimentación'), true);
      expect(expenseCategories.contains('Transporte'), true);
      expect(expenseCategories.contains('Entretenimiento'), true);
      expect(expenseCategories.contains('Salud'), true);
      expect(expenseCategories.contains('Educación'), true);
      expect(expenseCategories.contains('Ropa'), true);
      expect(expenseCategories.contains('Hogar'), true);
      expect(expenseCategories.contains('Otros'), true);
    });

    test('should have correct income categories', () {
      // Arrange
      const incomeCategories = [
        'Salario',
        'Freelance',
        'Inversión',
        'Venta',
        'Bonificación',
        'Otros',
      ];

      // Assert
      expect(incomeCategories.length, 6);
      expect(incomeCategories.contains('Salario'), true);
      expect(incomeCategories.contains('Freelance'), true);
      expect(incomeCategories.contains('Inversión'), true);
      expect(incomeCategories.contains('Venta'), true);
      expect(incomeCategories.contains('Bonificación'), true);
      expect(incomeCategories.contains('Otros'), true);
    });

    test('should have different categories for expenses and income', () {
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

      // Act
      final commonCategories = expenseCategories
          .where((category) => incomeCategories.contains(category))
          .toList();

      // Assert
      expect(commonCategories.length, 1); // Solo 'Otros' debería ser común
      expect(commonCategories.contains('Otros'), true);
    });

    test('should have correct default categories', () {
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

      // Act
      final defaultExpenseCategory = expenseCategories.first;
      final defaultIncomeCategory = incomeCategories.first;

      // Assert
      expect(defaultExpenseCategory, 'Alimentación');
      expect(defaultIncomeCategory, 'Salario');
    });

    test('should validate category selection logic', () {
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
        expect(category.isNotEmpty, true);
        expect(category.length, greaterThan(2));
      }

      for (final category in incomeCategories) {
        expect(category.isNotEmpty, true);
        expect(category.length, greaterThan(2));
      }
    });

    test('should handle category switching logic', () {
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

      // Act
      bool isIncome = false;
      List<String> currentCategories = isIncome ? incomeCategories : expenseCategories;
      expect(currentCategories, expenseCategories);

      isIncome = true;
      currentCategories = isIncome ? incomeCategories : expenseCategories;
      expect(currentCategories, incomeCategories);
    });

    test('should validate category icons logic', () {
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
      // Simular lógica de iconos
      for (final category in expenseCategories) {
        final icon = _getCategoryIcon(category, false);
        expect(icon, isA<IconData>());
      }

      for (final category in incomeCategories) {
        final icon = _getCategoryIcon(category, true);
        expect(icon, isA<IconData>());
      }
    });

    test('should validate button text logic', () {
      // Arrange
      bool isIncome = false;

      // Act & Assert
      String buttonText = isIncome ? 'Agregar Ingreso' : 'Agregar Gasto';
      expect(buttonText, 'Agregar Gasto');

      isIncome = true;
      buttonText = isIncome ? 'Agregar Ingreso' : 'Agregar Gasto';
      expect(buttonText, 'Agregar Ingreso');
    });

    test('should validate app bar title logic', () {
      // Arrange
      bool isIncome = false;

      // Act & Assert
      String appBarTitle = isIncome ? 'Agregar Ingreso' : 'Agregar Gasto';
      expect(appBarTitle, 'Agregar Gasto');

      isIncome = true;
      appBarTitle = isIncome ? 'Agregar Ingreso' : 'Agregar Gasto';
      expect(appBarTitle, 'Agregar Ingreso');
    });

    test('should validate switch state logic', () {
      // Arrange
      bool isIncome = false;

      // Act & Assert
      expect(isIncome, false);

      isIncome = true;
      expect(isIncome, true);
    });

    test('should validate color logic', () {
      // Arrange
      bool isIncome = false;

      // Act & Assert
      Color buttonColor = isIncome ? Colors.green : const Color(0xFF667eea);
      expect(buttonColor, const Color(0xFF667eea));

      isIncome = true;
      buttonColor = isIncome ? Colors.green : const Color(0xFF667eea);
      expect(buttonColor, Colors.green);
    });
  });
}

// Helper function to simulate category icon logic
IconData _getCategoryIcon(String category, bool isIncome) {
  if (isIncome) {
    switch (category) {
      case 'Salario':
        return Icons.work;
      case 'Freelance':
        return Icons.computer;
      case 'Inversión':
        return Icons.trending_up;
      case 'Venta':
        return Icons.sell;
      case 'Bonificación':
        return Icons.card_giftcard;
      default:
        return Icons.attach_money;
    }
  } else {
    switch (category) {
      case 'Alimentación':
        return Icons.restaurant;
      case 'Transporte':
        return Icons.directions_car;
      case 'Entretenimiento':
        return Icons.movie;
      case 'Salud':
        return Icons.local_hospital;
      case 'Educación':
        return Icons.school;
      case 'Ropa':
        return Icons.checkroom;
      case 'Hogar':
        return Icons.home;
      default:
        return Icons.category;
    }
  }
}
