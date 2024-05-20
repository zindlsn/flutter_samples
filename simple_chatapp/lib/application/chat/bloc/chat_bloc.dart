import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:start/core/exexptions/firebase_exeption.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  FirebaseDataSource firebaseDataSource =
      GetIt.instance.get<FirebaseDataSource>();
  ChatBloc() : super(ChatInitial()) {
    on<LoadChat>((event, emit) async {
      try {
        List<MessageEntity> messages =
            await firebaseDataSource.loadMessagesByChatId(event.chatId);
        emit(ChatLoaded(loadedMessages: messages));
      } on CoutNotLoadFirebaseExeption {
        emit(ChatLoadedFailed());
      }
    });
    on<InitChat>((event, emit) async {});
  }
}
