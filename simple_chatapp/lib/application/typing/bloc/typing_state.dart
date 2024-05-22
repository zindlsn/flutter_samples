part of 'typing_bloc.dart';
/*
@immutable
class TypingState {
  final bool isTyping;
  final ChatEntity chat;
  final String userId;

  const TypingState(
      {required this.isTyping, required this.chat, required this.userId});

  TypingState copyWith(
      {required bool isTyping,
      required ChatEntity chat,
      required String userId}) {
    return TypingState(isTyping: isTyping, chat: chat, userId: userId);
  }
}

final class IsTypingState extends TypingState {
  const IsTypingState(
      {required super.isTyping, required super.chat, required super.userId});
}

final class NotTypingState extends TypingState {
  const NotTypingState({required super.isTyping, required super.chat, required super.userId});
}
 */

@immutable
class TypingState {
  const TypingState();
}

final class InitTyping extends TypingState {}

final class IsTypingState extends TypingState {
  final ChatEntity chat;
  final String userId;
  final bool isTyping;
  const IsTypingState(
      {required this.isTyping, required this.chat, required this.userId});
}
