part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {
  final UserEntity userEntity;
  ChatInitial({required this.userEntity});
}

class ChatLoaded extends ChatState {
  final UserEntity userEntity;
  ChatLoaded({required this.userEntity});
}
