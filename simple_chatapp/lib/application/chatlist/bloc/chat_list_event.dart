part of 'chat_list_bloc.dart';

@immutable
sealed class ChatListEvent {}

final class LoadChatList extends ChatListEvent {
}
