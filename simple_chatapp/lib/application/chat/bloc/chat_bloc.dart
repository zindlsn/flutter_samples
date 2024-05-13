import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  FirebaseDataSource firebaseDataSource =
      GetIt.instance.get<FirebaseDataSource>();
  ChatBloc() : super(ChatInitial()) {
    on<InitChat>((event, emit) async {
      bool isTyping = false;
      try {
        await for (var snapshot
            in firebaseDataSource.firestore.collection('typing').snapshots()) {
          final result = snapshot.docs.map((doc) {
            final data = doc.data();
            return Tuple2(data['isTyping'] as bool, data['userId'] as String);
          }).first;
          isTyping = result.item1;
        }
        emit(
          state.copyWith(isTyping: isTyping),
        );
        // ignore: empty_catches
      } catch (e) {}
    });
    on<LoadChat>((event, emit) async {
      List<MessageEntity> messages =
          await firebaseDataSource.loadMessagesByChatId("0");
      emit(ChatLoaded(loadedMessages: messages));
    });
    on<StopTyping>((event, emit) {});
  }
}
