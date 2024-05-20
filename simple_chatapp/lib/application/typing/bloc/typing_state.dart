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

final class IsTypingState extends TypingState {
  const IsTypingState({required super.isTyping});
}
