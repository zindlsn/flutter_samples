part of 'typing_bloc.dart';

@immutable
abstract class TypingEvent {}

class TypingChanged extends TypingEvent {
  final bool isTyping;

  TypingChanged({required this.isTyping});
}

class TypingListeningInit extends TypingEvent {}
