import 'package:flutter/material.dart';

class Toastutils {
  static void showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, textAlign: TextAlign.center),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        width: 120,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
