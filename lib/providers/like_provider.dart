import 'package:flutter/material.dart';

class FavProvider with ChangeNotifier {
  final List<String> _favList = [];

  List<String> get getfavLists => _favList;

  set setFavIds(List<String> favIds) {
    _favList.addAll(favIds);
    notifyListeners();
  }

  removefavList(String value) {
    _favList.remove(value);
    notifyListeners();
  }

  clearfavList() {
    _favList.clear();
    notifyListeners();
  }
}
