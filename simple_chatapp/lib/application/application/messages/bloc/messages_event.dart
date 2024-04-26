part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {}

class SendMessage extends MessagesEvent {
  final String text;

  SendMessage({required this.text});
}

class MessagesInitial extends MessagesEvent {
  MessagesInitial();
}

class LoadMoreMessage extends MessagesEvent {
  LoadMoreMessage();
}

class SendMessageEvent extends MessagesEvent {
  SendMessageEvent();
}

class StartTypingEvent extends MessagesEvent {
  final String userId;

  StartTypingEvent(this.userId);
}

class StopTypingEvent extends MessagesEvent {
  final String userId;

  StopTypingEvent(this.userId);
}

class SubscribeToMessagesEvent extends MessagesEvent {
  SubscribeToMessagesEvent();
}

class SubscribeToTypingEvent extends MessagesEvent {
  SubscribeToTypingEvent();
}
