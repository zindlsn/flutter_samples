part of 'chat_bloc.dart';

@immutable
class ChatState {
  bool isTyping = false;
  String? typingUserId = "";

  ChatState({
    this.isTyping = false,
    this.typingUserId,
  });

  ChatState copyWith({
    bool? isTyping,
    String? typingUserId,
  }) {
    return ChatState(
      isTyping: isTyping ?? this.isTyping,
      typingUserId: typingUserId ?? this.typingUserId,
    );
  }
}

final class ChatInitial extends ChatState {}

final class LoadingChat extends ChatState {}

final class ChatLoaded extends ChatState {
  List<MessageEntity> loadedMessages = [];
  ChatLoaded({required this.loadedMessages});

  ChatLoaded copyWith({
    List<MessageEntity>? loadedMessages,
    bool? isTyping,
    String? typingUserId,
  }) {
    return ChatLoaded(
      loadedMessages: loadedMessages ?? this.loadedMessages,
    );
  }
}