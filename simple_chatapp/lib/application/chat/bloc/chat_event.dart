part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class InitChat extends ChatEvent {}

final class LoadChat extends ChatEvent {
  final String chatId;
  LoadChat({required this.chatId});
}
