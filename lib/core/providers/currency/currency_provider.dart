import 'package:flutter/material.dart';

class CurrencyProvider with ChangeNotifier {
  String _selectedCurrency = 'Binance'; // Default selection

  String get selectedCurrency => _selectedCurrency;

  void selectCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }
}
