import 'package:intl/intl.dart';
import '../models/currency.dart';

class CurrencyFormatter {
  /// Formatea un número con la moneda especificada
  /// Ejemplo: formatCurrency(15000, CurrencyData.currencies[0]) -> $15.000
  static String formatCurrency(double amount, Currency currency) {
    final formatter = NumberFormat.currency(
      locale: currency.locale,
      symbol: currency.symbol,
      decimalDigits: currency.decimalDigits,
    );
    return formatter.format(amount);
  }

  /// Formatea un número con la moneda por código
  /// Ejemplo: formatCurrencyByCode(15000, 'COP') -> $15.000
  static String formatCurrencyByCode(double amount, String currencyCode) {
    final currency = CurrencyData.getByCode(currencyCode);
    if (currency == null) {
      // Fallback a pesos colombianos si no se encuentra la moneda
      return formatCurrency(amount, CurrencyData.getDefault());
    }
    return formatCurrency(amount, currency);
  }

  /// Formatea un número como pesos colombianos (método legacy)
  /// Ejemplo: 15000 -> $15.000
  static String formatPesos(double amount) {
    return formatCurrency(amount, CurrencyData.getDefault());
  }

  /// Obtiene el símbolo de la moneda por código
  static String getSymbolByCode(String currencyCode) {
    final currency = CurrencyData.getByCode(currencyCode);
    return currency?.symbol ?? '\$';
  }

  /// Obtiene el nombre de la moneda por código
  static String getNameByCode(String currencyCode) {
    final currency = CurrencyData.getByCode(currencyCode);
    return currency?.name ?? 'Peso Colombiano';
  }

  /// Obtiene la moneda por código
  static Currency? getCurrencyByCode(String currencyCode) {
    return CurrencyData.getByCode(currencyCode);
  }
}
