part of 'typing_bloc.dart';

@immutable
abstract class TypingEvent {}

class TypingChanged extends TypingEvent {
  final bool isTyping;

  TypingChanged({required this.isTyping});
}

class TypingListeningInit extends TypingEvent {
  String chatId;
  TypingListeningInit({required this.chatId});
}

class StartTypingEvent extends TypingEvent {
  String userId;
  StartTypingEvent({required this.userId});
}

class StopTypingEvent extends TypingEvent {
  String userId;
  StopTypingEvent({required this.userId});
}
