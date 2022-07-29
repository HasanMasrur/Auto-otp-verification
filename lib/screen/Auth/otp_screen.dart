import 'package:auto_opt_varifacation/screen/Auth/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  // final String phone;
  // OtpScreen(this.phone, );
  @override
  _RegistationScreen createState() => _RegistationScreen();
}

class _RegistationScreen extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    fillOtp();
  }

  void fillOtp() async {
    await SmsAutoFill().listenForCode;
    print("Waiting for OTP" + SmsAutoFill().code.toString());
    //print(SmsAutoFill().getAppSignature);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  //BuildContext _context;
  final PageController _pageController = PageController(initialPage: 1);
  int _pageIndex = 0;
  String? pin = '';

  bool ischeck = false;

  final BoxDecoration pinPutDecoration = BoxDecoration(
    // color: const Color.fromRGBO(43, 46, 66, 1),
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
      //  color: Colors.black,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(CupertinoIcons.back, color: Color(0xffb8242a), size: 6.0.h),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(
              left: 15.0.w,
              right: 15.0.w,
            ),
            height: 87.0.h,
            width: 100.0.w,
            child: Column(
              children: [
                SizedBox(
                  height: 10.0.h,
                ),
                Center(
                  child: Text('OTP',
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffb8242a),
                      )),
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Container(
                  height: 8.0.h,
                  width: 100.0.w,
                  child: Builder(
                    builder: (context) {
                      return PageView(
                          scrollDirection: Axis.horizontal,
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() => _pageIndex = index);
                          },
                          children: [
                            onlySelectedBorderPinPut(),
                          ]);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                /*
                Custom Button:
                perimeter : onpressed 
                type: void Function()? onPressed;
                 */
                CustomButton(
                  onPressed: () {
                    if (pin!.length == 4) {}
                  },
                )
              ],
            )),
      ),
    );
  }

  Widget onlySelectedBorderPinPut() {
    return Form(
      key: _formKey,
      child: PinFieldAutoFill(
        decoration: UnderlineDecoration(
          textStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          colorBuilder: FixedColorBuilder(Color(0xffb8242a)),
          bgColorBuilder: FixedColorBuilder(Color(0xffb8242a)),
        ),
        codeLength: 4,
        cursor: Cursor(
          width: 2,
          height: 35,
          color: Color(0xffb8242a),
          radius: Radius.circular(15),
          enabled: true,
        ),
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        onCodeChanged: (val) {
          pin = val;
          print("Autofilled " + pin.toString());
        },
        onCodeSubmitted: (val) {
          print("Submitted " + val);
        },
      ),
    );
  }
}
