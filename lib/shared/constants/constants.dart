import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


navigateTo({
  required context,
  required Widget screen,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => screen,
    ),
  );
}

navigateAndFinishTo({
  required context,
  required Widget screen,
}) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => screen,
    ),
  );
}



showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.FAILED:
      return Colors.red;
    case ToastStates.WARNING:
      return Colors.amber;
  }
}

//  enum
enum ToastStates { SUCCESS, FAILED, WARNING }
