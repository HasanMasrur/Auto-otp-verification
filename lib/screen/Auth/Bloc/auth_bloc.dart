import 'package:auto_opt_varifacation/screen/Auth/Bloc/auth_event.dart';
import 'package:auto_opt_varifacation/screen/Auth/Bloc/auth_state.dart';
import 'package:auto_opt_varifacation/screen/constantdata/constantdata.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/ApiProvider.dart';
import '../../data/api_exception/network_exceptions.dart';

enum UnSuccessful { unAuthorize, other }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ApiProvider? apiProvider;
  AuthBloc({this.apiProvider}) : super(AuthInitial()) {
    on<AuthEvent>(((event, emit) async {
      if (event is AuthPhoneNumberButtonPressedEvent) {
        emit(AuthLoading());
        final Map<String, dynamic>? authdata = {
          'phone': event.phone_no,
          'app_key': event.app_key,
        };
        await apiProvider
            ?.login(url: '${ConstantData.SIGNUP_OTP}', authdata: authdata)
            .then((Either<DioError, Response> response) {
          response.fold((l) {
            print(
                "Failed TO FETCHED Help Repos! [${l.response?.statusCode}] -> [[${l.type.toString()}]]");
            final type = NetworkExceptions.getDioException(l);
            final message = NetworkExceptions.getErrorMessage(type);
            emit(AuthLoadingUnsuccessful(
                message: message,
                reason: message == "Unauthorized"
                    ? UnSuccessful.unAuthorize
                    : UnSuccessful.other));
          }, (r) {
            Map<String, dynamic> dataMap = r.data as Map<String, dynamic>;
            emit(AuthenticateSuccess(
              data: dataMap,
            ));
          });
        });
      }
      /*
      Otp Submit 
      */
      if (event is AuthPhoneNumberVerfiedUsingOtp) {
        emit(AuthLoading());
        final Map<String, dynamic>? authdata = {
          'phone': event.phone_no,
          'code': event.code,
        };
        await apiProvider
            ?.login(
                url: '${ConstantData.VALIDATE_SIGNUP_OTP}', authdata: authdata)
            .then((Either<DioError, Response> response) {
          response.fold((l) {
            print(
                "Failed TO FETCHED Help Repos! [${l.response?.statusCode}] -> [[${l.type.toString()}]]");
            final type = NetworkExceptions.getDioException(l);
            final message = NetworkExceptions.getErrorMessage(type);
            emit(AuthLoadingUnsuccessful(
                message: message,
                reason: message == "Unauthorized"
                    ? UnSuccessful.unAuthorize
                    : UnSuccessful.other));
          }, (r) {
            Map<String, dynamic> dataMap = r.data as Map<String, dynamic>;
            emit(AuthenticateSuccess(
              data: dataMap,
            ));
          });
        });
      }
    }));
  }
}
