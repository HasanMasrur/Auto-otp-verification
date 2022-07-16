// import 'package:burgundy_rider_app/Utils/api_exception/network_exceptions.dart';
// import 'package:burgundy_rider_app/data/dataprovider/internal_storage/internal_app_storage.dart';
// import 'package:burgundy_rider_app/presentations/screens/LoginScreen/Auth/authentication_bloc.dart';
// import 'package:burgundy_rider_app/presentations/screens/LoginScreen/LoginBloc/login_bloc.dart';
// import 'package:burgundy_rider_app/presentations/screens/LoginScreen/login_screen.dart';
// import 'package:burgundy_user_app/presentations/screens/LoginScreen/BLOC/LoginBloc/login_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class APIUnsuccessAction {
//   static Future<String?> reason(
//       DioError exceptions, BuildContext context, String fromPage) async {
//     final type = NetworkExceptions.getDioException(exceptions);
//     final message = NetworkExceptions.getErrorMessage(type);
//     final token = await StorageService().getToken();

//     if (message == "Unauthorized") {
//       context.read<LoginBloc>().add(LogoutDiver(token: token));
//       context.read<AuthenticationBloc>().add(const LogoutDriver());

//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (Route<dynamic> route) => false);

//       return message;
//     }
//     return message;
//   }

//   APIUnsuccessAction._();
// }
