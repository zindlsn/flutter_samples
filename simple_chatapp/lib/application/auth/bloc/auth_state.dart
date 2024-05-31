part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class VerificationLinkClicked extends AuthState {
  final String token;
  final String user;

  VerificationLinkClicked({required this.token, required this.user});
}
