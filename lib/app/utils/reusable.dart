// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grootan_task_app/app/extension/string_extension.dart';

import '../core/size.dart';

//=================================================================================================
///Error SnackBar
isErrorSnackBar(
  BuildContext context, {
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    showSimpleSnackbar(
      backgroundColor: Colors.red,
      text: message.toTitleCase(),
      textcolor: Colors.white,
      time: 1,
    ),
  );
}

///Success SnackBar
isSuccessSnackBar(
  BuildContext context, {
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    showSimpleSnackbar(
      backgroundColor: Colors.green,
      text: message.toTitleCase(),
      textcolor: Colors.white,
      time: 1,
    ),
  );
}

/// SnackBar Child
showSimpleSnackbar({
  required Color backgroundColor,
  required String text,
  required Color textcolor,
  required int time,
}) {
  return SnackBar(
    margin: EdgeInsets.only(
      right: AppSize.s5!,
      left: AppSize.s5!,
      bottom: AppSize.s5!,
    ),
    content: Text(
      text,
      style: TextStyle(color: textcolor),
    ),
    backgroundColor: backgroundColor,
    duration: Duration(seconds: time),
    behavior: SnackBarBehavior.floating,
  );
}

/// Toast Messages
toastMsg({
  Color? backgroundColor,
  required String text,
  Color? textcolor,
}) {
  Fluttertoast.showToast(
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    msg: text.toTitleCase(),
    backgroundColor: backgroundColor,
    textColor: textcolor,
  );
}

///Reusable
class Reusable {
  static List<BoxShadow> boxshadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 2,
      offset: const Offset(0, 1), // changes position of shadow
    ),
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 2,
      offset: const Offset(-1, 0), // changes position of shadow
    ),
  ];
  static List<BoxShadow> boxshadowSingle = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 5,
      // changes position of shadow
    ),
  ];
  static displayLessString(String displayText, int i) {
    return (displayText.isNotEmpty && displayText.length > i)
        ? ("${displayText.substring(0, i)}...".toTitleCase())
        : displayText.toTitleCase();
  }

  static cartItemLength(int textLength) {
    return (textLength > 9) ? "9+" : textLength.toString();
  }

  static removeDecimalZeroFormat(num n) {
    String value = n.toString().replaceAll(".0", '');
    return value;
  }

  static convertColorCode(String code) {
    Color color = Color(int.parse(code.replaceAll("#", "0xFF")));
    return color;
  }
}
