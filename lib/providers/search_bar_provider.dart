import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  bool _isSearchActive = false;
  bool _showSearchIcon = false; 
  bool get isSearchActive => _isSearchActive;
  bool get showSearchIcon => _showSearchIcon; 

  void toggleSearch() {
    _isSearchActive = !_isSearchActive;
    notifyListeners();
  }

  void setShowSearchIcon(bool showIcon) {
    _showSearchIcon = showIcon;
    notifyListeners();
  }

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
