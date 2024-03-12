import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  static Future<String?> getImageFromGallery() async {
    final pickedFile = await ImagePicker()
        .pickImage(imageQuality: 100, source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      return image.path;
    } else {
      return null;
    }
  }

  static Future<String?> getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      return image.path;
    } else {
      return null;
    }
  }

  static Future<String?> getVideo() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      File image = File(pickedVideo.path);
      return image.path;
    } else {
      return null;
    }
  }
}
