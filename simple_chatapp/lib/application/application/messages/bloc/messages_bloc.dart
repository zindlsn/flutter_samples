import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/core/server.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';
import 'package:start/domain/usecases/sendmessage/send_chat_message.dart';
import 'package:start/main.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  LoadChatMessageUsecase loadChatUsecase;
  SendChatMessageUsecase sendChatMessageUsecase;

  List<MessageEntity> messages = [];
  MessagesBloc(
      {required this.loadChatUsecase, required this.sendChatMessageUsecase})
      : super(MessagesInitial()) {
    Test();
    on<LoadMoreMessage>((state, emit) async {
      try {
        messages = [];
        messages.addAll(await loadChatUsecase.loadChatByUserId(
            id: "101"));
      } on Exception {
        emit(FailureMessageLoaded());
      }
      emit(MessagesLoaded());
    });

    on<SendMessage>((state, emit) {
      sendChatMessageUsecase.sendChatMessage(
        MessageEntity(
          ownerId: me.userId,
          text: state.text,
          creationDate: DateTime.now().add(const Duration(seconds: 20)),
        )..sendFromMe = true,
      );
    });
  }
}
