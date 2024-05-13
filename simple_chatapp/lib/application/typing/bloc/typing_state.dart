part of 'typing_bloc.dart';

@immutable
class TypingState {
  final bool isTyping;

  TypingState({required this.isTyping});

  TypingState copyWith({
    required bool isTyping,
  }) {
    return TypingState(
      isTyping: isTyping,
    );
  }
}
