import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils_ {
  fireToast(String massage) {
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        fontSize: 16.0);
  }
}
