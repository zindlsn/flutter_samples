part of 'messages_bloc.dart';

@immutable
abstract class MessagesEvent {}

class SendMessage extends MessagesEvent{
  final String text;

  SendMessage({required this.text});
}

class LoadMoreMessage extends MessagesEvent{

  LoadMoreMessage();
}