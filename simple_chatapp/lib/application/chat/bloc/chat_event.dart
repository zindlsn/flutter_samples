part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class LoadChat extends ChatEvent{
  final UserEntity userEntity;
  LoadChat({required this.userEntity});
}



