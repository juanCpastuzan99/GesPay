import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

/// Configuración global para las pruebas
class TestConfig {
  static void setup() {
    // Configurar el binding de Flutter para pruebas
    TestWidgetsFlutterBinding.ensureInitialized();
    
    // Configurar el modo de prueba
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  }
  
  static void tearDown() {
    // Limpiar después de las pruebas
    debugDefaultTargetPlatformOverride = null;
  }
}

/// Datos de prueba comunes
class TestData {
  static const String testUserId = 'test-user-123';
  static const String testEmail = 'test@example.com';
  static const String testPassword = 'testpassword123';
  static const String testUserName = 'Test User';
  
  static DateTime get testDate => DateTime(2024, 1, 1);
  
  static List<Map<String, dynamic>> get testExpenses => [
    {
      'id': 'expense-1',
      'title': 'Test Expense 1',
      'amount': 100.0,
      'category': 'Food',
      'date': testDate,
      'description': 'Test description 1',
      'userId': testUserId,
    },
    {
      'id': 'expense-2',
      'title': 'Test Expense 2',
      'amount': -50.0,
      'category': 'Transport',
      'date': testDate,
      'description': 'Test description 2',
      'userId': testUserId,
    },
  ];
}
