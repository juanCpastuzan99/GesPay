import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/screens/expense/add_expense_screen.dart';

void main() {
  group('Expense Selector Tests', () {
    testWidgets('should show expense categories when isIncome is false', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: false);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('Agregar Gasto'), findsOneWidget);
      expect(find.text('Alimentación'), findsOneWidget);
      expect(find.text('Transporte'), findsOneWidget);
      expect(find.text('Entretenimiento'), findsOneWidget);
      expect(find.text('Salud'), findsOneWidget);
      expect(find.text('Educación'), findsOneWidget);
      expect(find.text('Ropa'), findsOneWidget);
      expect(find.text('Hogar'), findsOneWidget);
      expect(find.text('Otros'), findsOneWidget);
    });

    testWidgets('should show income categories when isIncome is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: true);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('Agregar Ingreso'), findsOneWidget);
      expect(find.text('Salario'), findsOneWidget);
      expect(find.text('Freelance'), findsOneWidget);
      expect(find.text('Inversión'), findsOneWidget);
      expect(find.text('Venta'), findsOneWidget);
      expect(find.text('Bonificación'), findsOneWidget);
      expect(find.text('Otros'), findsOneWidget);
    });

    testWidgets('should have correct default category for expenses', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: false);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      final dropdown = find.byType(DropdownButtonFormField<String>);
      expect(dropdown, findsOneWidget);

      // Verificar que la categoría por defecto es Alimentación
      expect(find.text('Alimentación'), findsOneWidget);
    });

    testWidgets('should have correct default category for income', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: true);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      final dropdown = find.byType(DropdownButtonFormField<String>);
      expect(dropdown, findsOneWidget);

      // Verificar que la categoría por defecto es Salario
      expect(find.text('Salario'), findsOneWidget);
    });

    testWidgets('should show correct switch state for expenses', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: false);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      final switchWidget = find.byType(SwitchListTile);
      expect(switchWidget, findsOneWidget);

      final switchListTile = tester.widget<SwitchListTile>(switchWidget);
      expect(switchListTile.value, false);
    });

    testWidgets('should show correct switch state for income', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: true);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      final switchWidget = find.byType(SwitchListTile);
      expect(switchWidget, findsOneWidget);

      final switchListTile = tester.widget<SwitchListTile>(switchWidget);
      expect(switchListTile.value, true);
    });

    testWidgets('should show correct button text for expenses', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: false);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('Agregar Gasto'), findsOneWidget);
    });

    testWidgets('should show correct button text for income', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: true);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('Agregar Ingreso'), findsOneWidget);
    });

    testWidgets('should show correct app bar title for expenses', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: false);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('Agregar Gasto'), findsOneWidget);
    });

    testWidgets('should show correct app bar title for income', (
      WidgetTester tester,
    ) async {
      // Arrange
      const widget = AddExpenseScreen(isIncome: true);

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('Agregar Ingreso'), findsOneWidget);
    });
  });
}
