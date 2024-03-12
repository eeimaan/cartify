import 'package:flutter/material.dart';

class ImagePickerProvider extends ChangeNotifier {
  String _imagePath = '';
   
  String get path => _imagePath;

  set setPath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  void setImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  void clearImage() {
    _imagePath = '';
    notifyListeners();
  }

  void addPath(String imagePath) {
    _imagePath = imagePath;
    notifyListeners();
  }
}

class VideoPicker extends ChangeNotifier {
  bool _isVideoSelected = false;

  bool get isVideoSelected => _isVideoSelected;

  set isVideoSelected(bool value) {
    _isVideoSelected = value;
    notifyListeners();
  }
}
