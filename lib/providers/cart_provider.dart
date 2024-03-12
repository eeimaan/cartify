import 'package:flutter/material.dart';

class CartCountProvider extends ChangeNotifier {
  int _totalQuantity = 0;

  set setCount(int value) {
    _totalQuantity += value;
    notifyListeners();
  }

  void deleteCount(int value) {
    _totalQuantity -= value;
    notifyListeners();
  }

  set count(int value) {
    _totalQuantity = value;
    notifyListeners();
  }

  int get getCount {
    return _totalQuantity;
  }

  void increment() {
    _totalQuantity++;
    notifyListeners();
  }

  void clear() {
    _totalQuantity = 0;
    notifyListeners();
  }

  void decrement() {
    if (_totalQuantity > 1) {
      _totalQuantity--;
      notifyListeners();
    }
  }
}

class CartPriceProvider extends ChangeNotifier {
  int _total = 0;
  int _subTotal = 0;
  int _delivery= 0;
  int _discount = 0;

  set addTotal(int value) {
    _total += value;
    notifyListeners();
  }

  set subtractTotal(int value) {
    _total -= value;
    notifyListeners();
  }

  set addSubTotal(int value) {
    _subTotal += value;
    notifyListeners();
  }

  set subtractSubTotal(int value) {
    _subTotal -= value;
    notifyListeners();
  }

  set settotal(int value) {
    _total = value;
    notifyListeners();
  }

  set setSubtotal(int value) {
    _subTotal = value;
    notifyListeners();
  }

  int get getTotal {
    return _total;
  }
   set setDelivery(int value) {
    _delivery = value;
    notifyListeners();
  }

  int get getDelivery {
    return _delivery;
  }
 set setDiscount(int value) {
    _discount = value;
    notifyListeners();
  }

  int get getDiscount {
    return _discount;
  }
  int get getSubTotal {
    return _subTotal;
  }

  void clear() {
    _total = 0;
    notifyListeners();
  }
}

class CounterProvider extends ChangeNotifier {
  int _count = 1;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void clear() {
    _count = 1;
    notifyListeners();
  }

  void decrement() {
    if (_count > 1) {
      _count--;
      notifyListeners();
    }
  }
}
