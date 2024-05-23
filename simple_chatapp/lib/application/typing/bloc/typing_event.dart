part of 'typing_bloc.dart';

@immutable
abstract class TypingEvent {}

class TypingChanged extends TypingEvent {
  final bool isTyping;

  TypingChanged({required this.isTyping});
}

final class TypingListeningInit extends TypingEvent {
  final String chatId;
  final ChatEntity chat;
  final String userId;
  TypingListeningInit(
      {required this.chatId, required this.chat, required this.userId});
}

final class StartTypingEvent extends TypingEvent {
  final String chatId;
  final ChatEntity chat;
  final String userId;
  StartTypingEvent(
      {required this.chatId, required this.chat, required this.userId});
}

final class StopTypingEvent extends TypingEvent {
  final String chatId;
  final ChatEntity chat;
  final String userId;
  StopTypingEvent(
      {required this.chatId, required this.chat, required this.userId});
}

final class ChangeIsTyping extends TypingEvent {
  final bool isTyping;
  final String chatId;
  final ChatEntity chat;
  final String userId;
  ChangeIsTyping(this.chatId, this.chat, this.userId, {required this.isTyping});
}
