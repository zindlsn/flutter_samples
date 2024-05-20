part of 'typing_bloc.dart';

@immutable
abstract class TypingEvent {}

class TypingChanged extends TypingEvent {
  final bool isTyping;

  TypingChanged({required this.isTyping});
}

final class TypingListeningInit extends TypingEvent {
  final String chatId;
  TypingListeningInit({required this.chatId});
}

final class StartTypingEvent extends TypingEvent {
  final String userId;
  StartTypingEvent({required this.userId});
}

final class StopTypingEvent extends TypingEvent {
  final String userId;
  StopTypingEvent({required this.userId});
}
