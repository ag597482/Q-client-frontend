import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Util{
   static void showToast(errorMesage) {
    Fluttertoast.showToast(
      msg: errorMesage,
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast message
      gravity: ToastGravity.BOTTOM, // Location where the toast message appears
      timeInSecForIosWeb:
          1, // Duration of the toast message for iOS and web platforms
      backgroundColor: Colors.black87, // Background color of the toast message
      textColor: Colors.white, // Text color of the toast message
    );
  }

}