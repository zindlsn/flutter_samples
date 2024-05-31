part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class StartLogin extends LoginEvent {}

final class AuthCheckRequestedEvent extends LoginEvent {}

final class PhoneLogin extends LoginEvent {
  String phoneNumber;
  PhoneLogin({required this.phoneNumber});
}

final class ConfirmPhoneNumber extends LoginEvent {
  String code;
  AuthenticationResult authResult;
  ConfirmPhoneNumber({required this.code, required this.authResult});
}

final class LoginSuccessful extends LoginEvent {}
