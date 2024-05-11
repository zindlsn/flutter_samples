import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      await firebaseDataSource.init();
      bool isTyping = false; // initialize isTyping to false
      try {
        await for (var snapshot
            in firebaseDataSource.firestore.collection('typing').snapshots()) {
          final result = snapshot.docs.map((doc) {
            final data = doc.data();
            return Tuple2(data['isTyping'] as bool, data['userId'] as String);
          }).first;
          isTyping = result.item1;
          emit(
            state.copyWith(isTyping: isTyping),
          );
        }
      } catch (e) {
        // handle error
      }
    });
    on<LoadChat>((event, emit) async {
      print("${state.isTyping}");
      List<MessageEntity> messages =
          await firebaseDataSource.loadMessagesByChatId("0");

      print("->+${state.isTyping}");
      emit(ChatLoaded(loadedMessages: messages)
          .copyWith(isTyping: state.isTyping));
    });
    on<StopTyping>((event, emit) {});
  }

  /* Future<void> _onSubscribeToTyping(
    SubscribeToTypingEvent event,
    Emitter<MessagesState> emit,
  ) async {
    firebaseDataSource.subscribeToTypingStatus();
    emit(
      MessagesState(messages: messages, isTyping: true),
    );
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
      } else {
        _timer?.cancel();
        firebaseDataSource.updateTypingStatus(false, "me");
        emit(
          MessagesState(messages: messages, isTyping: false),
        );
      }
    }); 
  }*/
}
