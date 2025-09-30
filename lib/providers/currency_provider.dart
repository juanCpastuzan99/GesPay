import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/currency.dart';

class CurrencyProvider extends ChangeNotifier {
  Currency _selectedCurrency = CurrencyData.getDefault();
  bool _isLoading = false;
  bool _isInitialized = false;

  Currency get selectedCurrency => _selectedCurrency;
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;

  /// Carga la moneda guardada desde SharedPreferences
  Future<void> loadCurrency() async {
    if (_isInitialized) return;

    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final currencyCode = prefs.getString('selected_currency') ?? 'COP';

      final currency = CurrencyData.getByCode(currencyCode);
      if (currency != null) {
        _selectedCurrency = currency;
      } else {
        // Fallback a peso colombiano si no se encuentra la moneda
        _selectedCurrency = CurrencyData.getDefault();
      }
      _isInitialized = true;
    } catch (e) {
      print('Error cargando moneda: $e');
      // Asegurar que siempre tengamos una moneda válida
      _selectedCurrency = CurrencyData.getDefault();
      _isInitialized = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Cambia la moneda seleccionada
  Future<void> setCurrency(Currency currency) async {
    _selectedCurrency = currency;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_currency', currency.code);
    } catch (e) {
      print('Error guardando moneda: $e');
    }
  }

  /// Cambia la moneda por código
  Future<void> setCurrencyByCode(String currencyCode) async {
    final currency = CurrencyData.getByCode(currencyCode);
    if (currency != null) {
      await setCurrency(currency);
    }
  }

  /// Obtiene todas las monedas disponibles
  List<Currency> get availableCurrencies => CurrencyData.currencies;

  /// Obtiene monedas por región
  List<Currency> getCurrenciesByRegion(String region) {
    return CurrencyData.getByRegion(region);
  }

  /// Verifica si una moneda está seleccionada
  bool isCurrencySelected(String currencyCode) {
    return _selectedCurrency.code == currencyCode;
  }
}
