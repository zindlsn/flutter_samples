part of 'messages_bloc.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoaded extends MessagesState {}

class FailureMessageLoaded extends MessagesState {}
class MessageLoading extends MessagesState {}
