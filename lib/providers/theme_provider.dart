import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  bool _isDark = true;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _isDark;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDark') ?? true; // Tema oscuro por defecto
    _themeMode = _isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme() {
    _isDark = !_isDark;
    _themeMode = _isDark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme();
    notifyListeners();
  }

  void _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDark);
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF6366F1), // Indigo moderno
        secondary: Color(0xFF8B5CF6), // Púrpura vibrante
        surface: Color(0xFF1E1E2E), // Fondo principal oscuro
        onSurface: Color(0xFFE4E4E7), // Texto principal
        error: Color(0xFFEF4444), // Rojo para errores
        onError: Color(0xFFFFFFFF), // Texto sobre error
        surfaceContainerHighest: Color(0xFF3F3F46), // Variantes de superficie
        onSurfaceVariant: Color(0xFFA1A1AA), // Texto secundario
      ),
      scaffoldBackgroundColor: const Color(0xFF0F0F23),
      cardColor: const Color(0xFF2A2A3E),
      dividerColor: const Color(0xFF3F3F46),
      shadowColor: const Color(0xFF000000),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF1E1E2E),
        foregroundColor: Color(0xFFE4E4E7),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6366F1),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF2A2A3E),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: const Color(0xFF000000).withValues(alpha: 0.3),
      ),
    );
  }
}
