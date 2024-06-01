part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class LoadingChat extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<MessageEntity> loadedMessages;
  final ChatRoomEntity chat;
  ChatLoaded({required this.loadedMessages, required this.chat});
}

final class ChatLoadedFailed extends ChatState {}
