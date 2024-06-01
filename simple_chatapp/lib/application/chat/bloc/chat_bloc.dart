import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:start/core/exexptions/firebase_exeption.dart';
import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/infrastructure/repositories/chat_data_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  FirebaseDataSource firebaseDataSource =
      GetIt.instance.get<FirebaseDataSource>();
  ChatRepositoryImpl chatRepositoryImpl =
      GetIt.instance.get<ChatRepositoryImpl>();
  ChatBloc() : super(ChatInitial()) {
    on<LoadChat>((event, emit) async {
      try {
        var messages =
            await firebaseDataSource.loadMessagesByChatId(event.chat.chatRoomId);
        event.chat.messages = messages;
        emit(ChatLoaded(chat: event.chat, loadedMessages: messages));
      } on CoutNotLoadFirebaseExeption {
        emit(ChatLoadedFailed());
      }
    });
    on<InitChat>((event, emit) async {});
  }
}
