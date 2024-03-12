import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_utils.dart';

class PaymentProvider with ChangeNotifier {
  int _selectedPaymentIndex = -1;
  String _paymentMethod = 'Select Payment Method';
  String _dateTime = '';
  String _transactionId = '000000';
  String _status = 'Unpaid';

  int get selectedPaymentIndex => _selectedPaymentIndex;
  String get getPaymentMethod => _paymentMethod;
  String get getDateTime => _dateTime;
  String get getTransactionId => _transactionId;
  String get getStatus => _status;
  void clearValues() {
    _selectedPaymentIndex = -1;
    _paymentMethod = 'Select Payment Method';
    _dateTime = formatOrderDate(DateTime.now().toString());
    _transactionId = '000000';
    _status = 'Unpaid';
    notifyListeners();
  }

  set setTransactionId(String id) {
    _transactionId = id;
    notifyListeners();
  }

  set setDateTime(String date) {
    _dateTime = date;
    notifyListeners();
  }

  set setPaymentMethod(String name) {
    _paymentMethod = name;
    notifyListeners();
  }

  set setStatus(String status) {
    _status = status;
    notifyListeners();
  }

  void setSelectedPaymentIndex(int index) {
    _selectedPaymentIndex = index;
    notifyListeners();
  }
}
