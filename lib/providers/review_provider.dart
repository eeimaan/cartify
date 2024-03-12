import 'package:flutter/material.dart';

class ReviewProvider with ChangeNotifier {
  num _reviewAverage =0.0 ;
  num _reviewCount = 0;

   get getAverage => _reviewAverage;
   get getReviewCount => _reviewCount;
  void setAverage (num index) {
    _reviewAverage = index;
    notifyListeners();
  }
  void setReviewCount (num index) {
    _reviewCount = index;
    notifyListeners();
  }
}
