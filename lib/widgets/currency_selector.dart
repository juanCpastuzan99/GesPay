import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';
import '../models/currency.dart';

class CurrencySelector extends StatelessWidget {
  final bool showAsDialog;
  final Function(Currency)? onCurrencySelected;

  const CurrencySelector({
    super.key,
    this.showAsDialog = false,
    this.onCurrencySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(
      builder: (context, currencyProvider, child) {
        if (showAsDialog) {
          return _buildDialog(context, currencyProvider);
        } else {
          return _buildDropdown(context, currencyProvider);
        }
      },
    );
  }

  Widget _buildDropdown(
    BuildContext context,
    CurrencyProvider currencyProvider,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Currency>(
          value: currencyProvider.selectedCurrency,
          isExpanded: true,
          items: currencyProvider.availableCurrencies.map((Currency currency) {
            return DropdownMenuItem<Currency>(
              value: currency,
              child: Row(
                children: [
                  Text(currency.flag, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    '${currency.name} (${currency.code})',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (Currency? newCurrency) {
            if (newCurrency != null) {
              currencyProvider.setCurrency(newCurrency);
              onCurrencySelected?.call(newCurrency);
            }
          },
        ),
      ),
    );
  }

  Widget _buildDialog(BuildContext context, CurrencyProvider currencyProvider) {
    return AlertDialog(
      title: const Text('Seleccionar Moneda'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: ListView.builder(
          itemCount: currencyProvider.availableCurrencies.length,
          itemBuilder: (context, index) {
            final currency = currencyProvider.availableCurrencies[index];
            final isSelected = currencyProvider.isCurrencySelected(
              currency.code,
            );

            return ListTile(
              leading: Text(
                currency.flag,
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(currency.name),
              subtitle: Text('${currency.code} - ${currency.symbol}'),
              trailing: isSelected
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              selected: isSelected,
              onTap: () {
                currencyProvider.setCurrency(currency);
                onCurrencySelected?.call(currency);
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

class CurrencySelectorButton extends StatelessWidget {
  const CurrencySelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(
      builder: (context, currencyProvider, child) {
        // Mostrar loading si está cargando
        if (currencyProvider.isLoading) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: Colors.white,
              ),
            ),
          );
        }

        return InkWell(
          onTap: () => _showCurrencyDialog(context, currencyProvider),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currencyProvider.selectedCurrency.flag,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 6),
                Text(
                  currencyProvider.selectedCurrency.code,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCurrencyDialog(
    BuildContext context,
    CurrencyProvider currencyProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => CurrencySelector(
        showAsDialog: true,
        onCurrencySelected: (currency) {
          // La moneda ya se cambió en el provider
        },
      ),
    );
  }
}
