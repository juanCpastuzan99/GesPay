import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Form Validators Tests', () {
    group('Email Validation', () {
      test('should validate correct email format', () {
        // Arrange
        const validEmails = [
          'test@example.com',
          'user@domain.org',
          'jcpastuzanq22@itp.edu.co',
          'admin@company.co.uk',
        ];

        // Act & Assert
        for (final email in validEmails) {
          expect(_isValidEmail(email), true, reason: 'Email $email should be valid');
        }
      });

      test('should reject invalid email format', () {
        // Arrange
        const invalidEmails = [
          'invalid-email',
          '@domain.com',
          'user@',
          'user.domain.com',
          '',
          'user@domain',
        ];

        // Act & Assert
        for (final email in invalidEmails) {
          expect(_isValidEmail(email), false, reason: 'Email $email should be invalid');
        }
      });
    });

    group('Password Validation', () {
      test('should validate password length', () {
        // Arrange
        const validPasswords = [
          '123456',
          'password123',
          '99p@stuzan',
          'MySecurePassword123',
        ];

        // Act & Assert
        for (final password in validPasswords) {
          expect(_isValidPassword(password), true, reason: 'Password should be valid');
        }
      });

      test('should reject short passwords', () {
        // Arrange
        const invalidPasswords = [
          '12345',
          'pass',
          'abc',
          '',
        ];

        // Act & Assert
        for (final password in invalidPasswords) {
          expect(_isValidPassword(password), false, reason: 'Password should be invalid');
        }
      });
    });

    group('Amount Validation', () {
      test('should validate positive amounts', () {
        // Arrange
        const validAmounts = [0.01, 1.0, 100.0, 999.99];

        // Act & Assert
        for (final amount in validAmounts) {
          expect(_isValidAmount(amount), true, reason: 'Amount $amount should be valid');
        }
      });

      test('should validate negative amounts', () {
        // Arrange
        const validAmounts = [-0.01, -1.0, -100.0, -999.99];

        // Act & Assert
        for (final amount in validAmounts) {
          expect(_isValidAmount(amount), true, reason: 'Amount $amount should be valid');
        }
      });

      test('should reject zero amount', () {
        // Act & Assert
        expect(_isValidAmount(0.0), false, reason: 'Zero amount should be invalid');
      });
    });
  });
}

// Helper functions for validation
bool _isValidEmail(String email) {
  if (email.isEmpty) return false;
  if (!email.contains('@')) return false;
  if (email.startsWith('@')) return false;
  if (email.endsWith('@')) return false;
  if (!email.contains('.')) return false;
  return true;
}

bool _isValidPassword(String password) {
  return password.length >= 6;
}

bool _isValidAmount(double amount) {
  return amount != 0.0;
}
