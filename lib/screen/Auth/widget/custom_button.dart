import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  void Function()? onPressed;
  CustomButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 6.0.h,
        width: 70.0.w,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: Colors.red)),
              primary: Color(0xffb8242a),
              //  onPrimary: Colors.black87,
              // elevation: 10.0,
              //  shadowColor: Colors.yellow[200],
            ),
            onPressed: onPressed,
            child: Text(
              'Next',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 2.0.h),
            )));
  }
}
