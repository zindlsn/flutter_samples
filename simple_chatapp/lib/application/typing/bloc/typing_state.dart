part of 'typing_bloc.dart';

@immutable
class TypingState {
  final bool isTyping;

  const TypingState({required this.isTyping});

  TypingState copyWith({
    required bool isTyping,
  }) {
    return TypingState(
      isTyping: isTyping,
    );
  }
}

class IsTypingState extends TypingState {
  IsTypingState({required super.isTyping});
}
