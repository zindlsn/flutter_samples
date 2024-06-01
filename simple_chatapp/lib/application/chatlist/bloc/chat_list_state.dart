part of 'chat_list_bloc.dart';

@immutable
sealed class ChatListState {}

final class ChatListInitial extends ChatListState {}

final class ChatListLoaded extends ChatListState {
  final List<ChatRoomEntity> chats;
  ChatListLoaded({required this.chats});
}
