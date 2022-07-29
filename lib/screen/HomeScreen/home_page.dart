import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          'Successfully Login',
          style: TextStyle(color: Colors.red, fontSize: 30),
        ))
      ],
    ));
  }
}
