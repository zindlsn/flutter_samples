part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class PhoneVerified extends LoginState {
  AuthenticationResult result;
  PhoneVerified({required this.result});
}
