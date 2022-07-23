import 'package:auto_opt_varifacation/screen/Auth/Bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticateSuccess extends AuthState {
  final dynamic data;

  const AuthenticateSuccess({this.data});
  @override
  List<Object> get props => [];
}

class AuthLoadingUnsuccessful extends AuthState {
  final UnSuccessful reason;
  final String message;
  const AuthLoadingUnsuccessful({
    required this.reason,
    required this.message,
  });
  @override
  List<Object> get props => [reason, message];
}
