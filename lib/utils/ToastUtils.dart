import 'package:flutter/material.dart';

class Toastutils {
  static bool showLoading = false;
  static void showToast(BuildContext context, String msg) {
    if (showLoading) {
      return;
    }
    showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, textAlign: TextAlign.center),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        width: 180,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
