import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/message_entity.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  List<MessageEntity> messages = [
    MessageEntity(ownerId: "101", text: "TEXT 1", sentTime: DateTime.now())
  ];
  MessagesBloc() : super(MessagesInitial()) {
    on<SendMessage>((state, emit) {
      messages.add(
        MessageEntity(
          ownerId: "101",
          text: "123",
          sentTime: DateTime.now(),
        )..sendFromMe = true,
      );
      emit(MessagesLoaded());
    });

    on<LoadMoreMessage>((state, emit) {
      messages.add(
        MessageEntity(
          ownerId: "101",
          text: "This is a very long message which shold be displayed to the message",
          sentTime: DateTime.now(),
        )..sendFromMe = true,
      );
      emit(MessagesLoaded());
    });
  }
}
