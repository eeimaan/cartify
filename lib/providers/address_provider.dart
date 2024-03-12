import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  String _defaultAddress = '';

  get getAddress => _defaultAddress;

  set setAddress(String address) {
    _defaultAddress = address;
    notifyListeners();
  }

  void clear() {
    _defaultAddress = '';
    notifyListeners();
  }
}
