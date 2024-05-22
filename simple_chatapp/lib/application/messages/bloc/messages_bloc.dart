import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/usecases/sendmessage/send_chat_message.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/main.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  SendChatMessageUsecase sendChatMessageUsecase;
  FirebaseDataSource firebaseDataSource;

  MessagesBloc(
      {required this.sendChatMessageUsecase, required this.firebaseDataSource})
      : super(MessageInitial()) {
    on<SendMessage>(
      (state, emit) async {
        await firebaseDataSource.sendMessage(
          MessageEntity(
            ownerId: me.userId,
            text: state.text,
            chatId: "V5QCuwyF5ddv9GCzlCBQ",
            sendFromMe: true,
            creationDate: DateTime.now().add(
              const Duration(seconds: 20),
            ),
          )..sendFromMe = true,
        );
      },
    );
  }
}
