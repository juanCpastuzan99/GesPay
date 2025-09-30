class Currency {
  final String code;
  final String name;
  final String symbol;
  final String locale;
  final int decimalDigits;
  final String flag;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.locale,
    required this.decimalDigits,
    required this.flag,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Currency && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => '$flag $name ($code)';
}

class CurrencyData {
  static const List<Currency> currencies = [
    // América Latina
    Currency(
      code: 'COP',
      name: 'Peso Colombiano',
      symbol: '\$',
      locale: 'es_CO',
      decimalDigits: 0,
      flag: '🇨🇴',
    ),
    Currency(
      code: 'MXN',
      name: 'Peso Mexicano',
      symbol: '\$',
      locale: 'es_MX',
      decimalDigits: 2,
      flag: '🇲🇽',
    ),
    Currency(
      code: 'ARS',
      name: 'Peso Argentino',
      symbol: '\$',
      locale: 'es_AR',
      decimalDigits: 2,
      flag: '🇦🇷',
    ),
    Currency(
      code: 'CLP',
      name: 'Peso Chileno',
      symbol: '\$',
      locale: 'es_CL',
      decimalDigits: 0,
      flag: '🇨🇱',
    ),
    Currency(
      code: 'BRL',
      name: 'Real Brasileño',
      symbol: 'R\$',
      locale: 'pt_BR',
      decimalDigits: 2,
      flag: '🇧🇷',
    ),
    
    // América del Norte
    Currency(
      code: 'USD',
      name: 'Dólar Estadounidense',
      symbol: '\$',
      locale: 'en_US',
      decimalDigits: 2,
      flag: '🇺🇸',
    ),
    Currency(
      code: 'CAD',
      name: 'Dólar Canadiense',
      symbol: 'C\$',
      locale: 'en_CA',
      decimalDigits: 2,
      flag: '🇨🇦',
    ),
    
    // Europa
    Currency(
      code: 'EUR',
      name: 'Euro',
      symbol: '€',
      locale: 'es_ES',
      decimalDigits: 2,
      flag: '🇪🇺',
    ),
    Currency(
      code: 'GBP',
      name: 'Libra Esterlina',
      symbol: '£',
      locale: 'en_GB',
      decimalDigits: 2,
      flag: '🇬🇧',
    ),
    Currency(
      code: 'CHF',
      name: 'Franco Suizo',
      symbol: 'CHF',
      locale: 'de_CH',
      decimalDigits: 2,
      flag: '🇨🇭',
    ),
    
    // Asia
    Currency(
      code: 'JPY',
      name: 'Yen Japonés',
      symbol: '¥',
      locale: 'ja_JP',
      decimalDigits: 0,
      flag: '🇯🇵',
    ),
    Currency(
      code: 'CNY',
      name: 'Yuan Chino',
      symbol: '¥',
      locale: 'zh_CN',
      decimalDigits: 2,
      flag: '🇨🇳',
    ),
    Currency(
      code: 'KRW',
      name: 'Won Surcoreano',
      symbol: '₩',
      locale: 'ko_KR',
      decimalDigits: 0,
      flag: '🇰🇷',
    ),
    Currency(
      code: 'INR',
      name: 'Rupia India',
      symbol: '₹',
      locale: 'hi_IN',
      decimalDigits: 2,
      flag: '🇮🇳',
    ),
    
    // Oceanía
    Currency(
      code: 'AUD',
      name: 'Dólar Australiano',
      symbol: 'A\$',
      locale: 'en_AU',
      decimalDigits: 2,
      flag: '🇦🇺',
    ),
    Currency(
      code: 'NZD',
      name: 'Dólar Neozelandés',
      symbol: 'NZ\$',
      locale: 'en_NZ',
      decimalDigits: 2,
      flag: '🇳🇿',
    ),
  ];

  static Currency getDefault() {
    return currencies.firstWhere((c) => c.code == 'COP');
  }

  static Currency? getByCode(String code) {
    try {
      return currencies.firstWhere((c) => c.code == code);
    } catch (e) {
      return null;
    }
  }

  static List<Currency> getByRegion(String region) {
    switch (region.toLowerCase()) {
      case 'america':
        return currencies.where((c) => 
          ['COP', 'MXN', 'ARS', 'CLP', 'BRL', 'USD', 'CAD'].contains(c.code)
        ).toList();
      case 'europe':
        return currencies.where((c) => 
          ['EUR', 'GBP', 'CHF'].contains(c.code)
        ).toList();
      case 'asia':
        return currencies.where((c) => 
          ['JPY', 'CNY', 'KRW', 'INR'].contains(c.code)
        ).toList();
      case 'oceania':
        return currencies.where((c) => 
          ['AUD', 'NZD'].contains(c.code)
        ).toList();
      default:
        return currencies;
    }
  }
}
