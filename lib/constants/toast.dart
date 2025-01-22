import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class AppToast {
  static show(
    String message, {
    bool error = false,
  }) {
    log("MESSAGE::::::: $message");
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor:
            error ? const Color.fromRGBO(244, 67, 54, 0.7) : Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
