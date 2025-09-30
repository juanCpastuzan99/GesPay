import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/providers/theme_provider.dart';

void main() {
  group('ThemeProvider Tests', () {
    late ThemeProvider themeProvider;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      themeProvider = ThemeProvider();
    });

    test('should initialize with dark theme by default', () {
      // Assert
      expect(themeProvider.isDark, true);
      expect(themeProvider.themeMode, ThemeMode.dark);
    });

    test('should toggle theme correctly', () {
      // Arrange
      final initialTheme = themeProvider.isDark;

      // Act
      themeProvider.toggleTheme();

      // Assert
      expect(themeProvider.isDark, !initialTheme);
      expect(themeProvider.themeMode, ThemeMode.light);
    });

    test('should toggle theme back to dark', () {
      // Arrange
      themeProvider.toggleTheme(); // Switch to light
      expect(themeProvider.isDark, false);

      // Act
      themeProvider.toggleTheme(); // Switch back to dark

      // Assert
      expect(themeProvider.isDark, true);
      expect(themeProvider.themeMode, ThemeMode.dark);
    });

    test('should provide light theme data', () {
      // Act
      final lightTheme = themeProvider.lightTheme;

      // Assert
      expect(lightTheme.brightness, Brightness.light);
      expect(lightTheme.useMaterial3, true);
    });

    test('should provide dark theme data', () {
      // Act
      final darkTheme = themeProvider.darkTheme;

      // Assert
      expect(darkTheme.brightness, Brightness.dark);
      expect(darkTheme.useMaterial3, true);
    });
  });
}
