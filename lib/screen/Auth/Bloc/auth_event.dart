import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthPhoneNumberButtonPressedEvent extends AuthEvent {
  final dynamic phone_no;
  final dynamic app_key;
  AuthPhoneNumberButtonPressedEvent({this.phone_no, this.app_key});
  @override
  List<Object> get props => [];
}
