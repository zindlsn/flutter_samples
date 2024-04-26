part of 'messages_bloc.dart';

@immutable
class MessagesState {
  final List<MessageEntity> messages;
  final bool isTyping;
  final String? typingUserId;

  const MessagesState({
    required this.messages,
    required this.isTyping,
    this.typingUserId,
  });

  factory MessagesState.initial() {
    return const MessagesState(
      messages: [],
      isTyping: false,
      typingUserId: null,
    );
  }

  MessagesState copyWith({
    List<MessageEntity>? messages,
    bool? isTyping,
    String? typingUserId,
  }) {
    return MessagesState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      typingUserId: typingUserId ?? this.typingUserId,
    );
  }
}

class MessagesLoaded extends MessagesState {
  MessagesLoaded({required super.messages, required super.isTyping});
}

class FailureMessageLoaded extends MessagesState {
  FailureMessageLoaded({required super.messages, required super.isTyping});
}

class MessageLoading extends MessagesState {
  MessageLoading({required super.messages, required super.isTyping});
}
