part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class InitChat extends ChatEvent {}

final class LoadChat extends ChatEvent {
  final ChatEntity chat;
  LoadChat({required this.chat});
}
