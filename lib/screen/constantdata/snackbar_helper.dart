import 'package:flutter/material.dart';

class SnackBarHelper {
  static showSnack({context, title, error = false}) {
    var snackBar = SnackBar(
      duration: Duration(milliseconds: 1000),
      content: Text(
        '$title',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      backgroundColor: !error ? Colors.grey : Colors.redAccent,
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}



//SnackBarHelper.showSnack(context: context,title: "Something Error!",error: false);