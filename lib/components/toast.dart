import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  // show toast for successful operation
  static void toastSuccess({required String content, Color? color}) {
    Fluttertoast.showToast(
      msg: content,
      gravity: ToastGravity.TOP,
      backgroundColor: color,
      fontSize: 17,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void toastError({
    required String content,
  }) {
    Fluttertoast.showToast(
        msg: content,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG);
  }

  static void toastWarning({required String content}) {
    Fluttertoast.showToast(
        msg: content,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        fontSize: 16,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.black);
  }
}
