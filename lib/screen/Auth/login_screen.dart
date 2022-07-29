// ignore_for_file: must_be_immutable, unnecessary_new, sort_child_properties_last

import 'package:auto_opt_varifacation/screen/Auth/Bloc/auth_bloc.dart';
import 'package:auto_opt_varifacation/screen/Auth/Bloc/auth_event.dart';
import 'package:auto_opt_varifacation/screen/Auth/Bloc/auth_state.dart';
import 'package:auto_opt_varifacation/screen/Auth/otp_screen.dart';
import 'package:auto_opt_varifacation/screen/Auth/widget/custom_button.dart';
import 'package:auto_opt_varifacation/screen/constantdata/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String phone = ' ';
  String phone_no = '';
  String? dropdownValue = 'Eng';
  List<String> lanvalur = ['Eng', 'বাংলা'];
  @override
  void initState() {
    phone = '';
    super.initState();
  }

  ErrorIcon _errorWidget = new ErrorIcon(false);

  set errorWidget(ErrorIcon value) {
    setState(() {
      _errorWidget = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(backgroundColor: Colors.white, body: buildProtraits()),
    );
  }

  Widget buildProtraits() {
    return SingleChildScrollView(
        child: Form(
      key: _globalKey,
      child: Container(
        height: 100.0.h,
        width: 100.0.w,
        child: Column(
          children: [
            SizedBox(
              height: 30.0.h,
            ),
            Center(
              child: Text('SignUp',
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffb8242a),
                  )),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: 5.0.h,
                  right: 5.0.h,
                ),
                height: 6.0.h,
                width: 70.0.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 0.2.h),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 3.0.w),
                  width: 70.0.w,
                  alignment: Alignment.center,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (text) async {
                      // DEFINE YOUR RULES HERE
                      // text[3].contains('1')
                      (text.contains("1") && text.length == 10)
                          ? (setState(() {
                              phone = '';
                              errorWidget = new ErrorIcon(false);
                              FocusScope.of(context).unfocus();
                              phone_no = text;
                            }))
                          : setState(() {
                              errorWidget = new ErrorIcon(true);
                              phone_no = '';
                            });
                    },
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      suffixIcon: _errorWidget,
                      prefixText: '+88 0',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Color(0xffb8242a), fontSize: 2.2.h),
                  ),
                )),
            SizedBox(height: 5.0.h),

            /*
                Custom Button:
                perimeter : onpressed 
                type: void Function()? onPressed;
                 */
            BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
              return CustomButton(
                onPressed: phone_no.length == 10
                    ? () async {
                        print('i ma working');

                        phone = "+880$phone_no";
                        print(phone.length);
                        attemptToLogin(phone_num: phone);
                      }
                    : () {
                        print(phone.length);
                      },
              );
            }, listener: (context, state) {
              if (state is AuthLoading) {
                EasyLoading.show();
              }
              if (state is AuthenticateSuccess) {
                EasyLoading.dismiss();
                SnackBarHelper.showSnack(
                    context: context,
                    error: false,
                    title: "OTP Successfully Send");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OtpScreen(phone)));
              }
              if (state is AuthLoadingUnsuccessful) {
                EasyLoading.dismiss();
                SnackBarHelper.showSnack(
                    context: context, error: true, title: "${state.message}");
              }
            }),
            SizedBox(
              height: 3.0.h,
            ),
          ],
        ),
      ),
    ));
  }

  attemptToLogin({phone_num}) async {
    String app_key = await SmsAutoFill().getAppSignature;
    BlocProvider.of<AuthBloc>(context).add(AuthPhoneNumberButtonPressedEvent(
        phone_no: phone_num, app_key: app_key));
  }
}

class ErrorIcon extends StatelessWidget {
  bool _isError;
  ErrorIcon(this._isError);
  bool get isError => _isError;
  @override
  Widget build(BuildContext context) {
    Widget out;
    debugPrint("Rebuilding ErrorWidget");
    isError
        ? out = new Icon(
            CupertinoIcons.add,
            color: Color(Colors.red.value),
          )
        : out = new Icon(null);

    return out;
  }
}
