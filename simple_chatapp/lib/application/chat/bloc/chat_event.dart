part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class LoadChat extends ChatEvent {
  LoadChat();
}
class SetChatpartner extends ChatEvent {
  UserEntity chatPartner;
  SetChatpartner({required this.chatPartner});
}
class SendChatMessage extends ChatEvent {
  final MessageEntity messageEntity;

  SendChatMessage({required this.messageEntity});
}
