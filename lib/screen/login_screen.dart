// ignore_for_file: must_be_immutable, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String phone = ' ';
  String phone_no = '';
  bool is_futurebuilder = false;
  bool is_futurebuilders = false;
  String? dropdownValue = 'Eng';

  List<String> lanvalur = ['Eng', 'বাংলা'];
  @override
  void initState() {
    phone = '';
    super.initState();
  }

  // Future _submitForm(
  //     BuildContext context, AuthProvider model, first_name, email) async {
  //   DialogLoaderClass.confirmDialog(context, 'Loading...');
  //   final Map<String, dynamic> authentication =
  //       await model.authenticationSocialMedia(first_name, email);
  //   print(authentication);
  //   if (authentication['success']) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => Dashboard()));
  //   } else {
  //     DialogClass.confirmDialog(context, authentication['message']);
  //   }
  // }

  // void sharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var a = await prefs.get('language');
  //   print(a);
  //   if (LocaleKeys.name.tr() == "Name") {
  //     setState(() {
  //       dropdownValue = "Eng";
  //     });
  //   } else {
  //     setState(() {
  //       dropdownValue = "বাংলা";
  //     });
  //   }
  //   // if (a != null) {
  //   //   setState(() {
  //   //     dropdownValue = a.toString();
  //   //   });
  //   // }
  // }

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
                height: 40.0.h,
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: 7.0.h,
                    right: 7.0.h,
                  ),
                  height: 6.0.h,
                  width: 70.0.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(width: 0.2.h),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 3.0.w),
                    width: 60.0.w,
                    alignment: Alignment.center,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (text) {
                        // DEFINE YOUR RULES HERE
                        // text[3].contains('1')
                        (text.contains("1") && text.length == 10)
                            ? setState(() {
                                phone = '';
                                errorWidget = new ErrorIcon(false);
                                FocusScope.of(context).unfocus();
                                print('Phone number is : ');
                                //  phone = "+880$text";
                                phone_no = text;

                                print(phone_no);
                              })
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
                      style:
                          TextStyle(color: Color(0xffb8242a), fontSize: 2.2.h),
                    ),
                  )),
              SizedBox(height: 3.0.h),
              Center(
                child: Container(
                    width: 25.0.w,
                    height: 4.5.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 2.0.h,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: phone_no.length == 10
                          ? () async {
                              print('i ma working');
                              print(phone.length);

                              phone = "+880$phone_no";
                            }
                          : () {
                              print(phone.length);
                            },
                    )),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                height: 3.0.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//   _submitFormauth(BuildContext context, AuthProvider singInModel) async {
//     debugPrint('Phone no is submitted');
//     String app_key = await SmsAutoFill().getAppSignature;
//     await singInModel.refreshtoken();
//     Map<String, dynamic>
//         // doctor Sign up
//         authentication = await singInModel.authentication(phone, app_key);
//     if (authentication['success']) {
//       ///   Navigator.pop(context, true);
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context) => OtpScreen(phone, "login")));
//     } else if (authentication['message'] == "already register") {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => SplashScreen()));
//     } else {
//       showDialog(
//           // barrierColor: Color(0xFFdab13c),
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               backgroundColor: Color(0xFFefe7dc),
//               title: Text(
//                 'An error Occurred',
//               ),
//               content: Text(
//                 authentication['message'],
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Ok'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             );
//           });
//     }
//   }
// }

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
            Icons.error,
            color: Color(Colors.red.value),
          )
        : out = new Icon(null);

    return out;
  }
}
