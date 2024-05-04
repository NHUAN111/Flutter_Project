import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class BaseToast {
  static void showSuccess(
      BuildContext context, String message, String description) {
    Toastification().show(
      context: context,
      alignment: Alignment.topCenter,
      title: Text(message),
      progressBarTheme: null,
      description: Text(description),
      style: ToastificationStyle.flat,
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  static void showError(
      BuildContext context, String message, String description) {
    Toastification().show(
      context: context,
      alignment: Alignment.topCenter,
      title: Text(message),
      progressBarTheme: null,
      description: Text(description),
      style: ToastificationStyle.flat,
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  static Future<bool?> showConfirmed(
    BuildContext context,
    String title,
    String content,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Xác nhận hủy
              },
              child: const Text('Đồng ý'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Hủy xác nhận
              },
              child: const Text('Hủy'),
            ),
          ],
        );
      },
    );
  }
}
