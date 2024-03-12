import 'package:flutter/material.dart';

class AppsDialogs {
  static showAppDialog(
      {required BuildContext context,
      Widget? content,
      bool barrierDismissible = true,
      List<Widget>? actions,
      double? elevation,
      Widget? title,
      Color? backgroundColor,
      ShapeBorder? shape}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        return AlertDialog(
          content: content,
          actions: actions,
          elevation: elevation,
          title: title,
          surfaceTintColor: backgroundColor,
          backgroundColor: backgroundColor,
          shape: shape,
        );
      },
    );
  }
}
