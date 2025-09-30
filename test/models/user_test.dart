import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aplication/models/user.dart';

void main() {
  group('User Model Tests', () {
    test('should create user from map', () {
      // Arrange
      final map = {
        'id': 'user-123',
        'email': 'test@example.com',
        'name': 'Test User',
        'createdAt': '2024-01-01T00:00:00.000',
      };

      // Act
      final user = User.fromMap(map);

      // Assert
      expect(user.id, 'user-123');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.createdAt, DateTime(2024, 1, 1));
    });

    test('should convert user to map', () {
      // Arrange
      final user = User(
        id: 'user-123',
        email: 'test@example.com',
        name: 'Test User',
        createdAt: DateTime(2024, 1, 1),
      );

      // Act
      final map = user.toMap();

      // Assert
      expect(map['id'], 'user-123');
      expect(map['email'], 'test@example.com');
      expect(map['name'], 'Test User');
      expect(map['createdAt'], '2024-01-01T00:00:00.000');
    });

    test('should handle empty strings correctly', () {
      // Arrange
      final map = {
        'id': 'user-123',
        'email': 'test@example.com',
        'name': '',
        'createdAt': '2024-01-01T00:00:00.000',
      };

      // Act
      final user = User.fromMap(map);

      // Assert
      expect(user.name, '');
    });
  });
}
