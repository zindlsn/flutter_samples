part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignOutPressed extends AuthEvent {}

class AuthCheckRequestedEvent extends AuthEvent {}

class AuthInitEvent extends AuthEvent {}

class VerificationLinkClick extends AuthEvent {
  final String token;
  final String key;
  VerificationLinkClick({required this.token, required this.key});
}
