import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';

part 'typing_event.dart';
part 'typing_state.dart';

class TypingBloc extends Bloc<TypingEvent, TypingState> {
  FirebaseDataSource firebaseDataSource;
  Timer? _timer;
  int _secondsRemaining = 5;
  TypingBloc({required this.firebaseDataSource}) : super(InitTyping()) {
    on<TypingListeningInit>((event, emit) async {});
    on<StartTypingEvent>(_onStartTyping);
    on<StopTypingEvent>(_onStopTyping);
  }
  bool _storeIsTyping = false;

  FutureOr<void> _onStartTyping(
    StartTypingEvent event,
    Emitter<IsTypingState> emit,
  ) async {
    _timer?.cancel();
    if (!_storeIsTyping) {
      _storeIsTyping = await firebaseDataSource.updateTypingStatus(
          true, event.chat.chatId, event.userId);
    }
    emit(IsTypingState(isTyping: true, chat: event.chat, userId: event.userId));
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
      } else {
        timer.cancel();
        await firebaseDataSource.deleteTypingDocument(
            event.chat.chatId, event.userId);
        _storeIsTyping = false;
      }
    });
  }

  Future<void> _onStopTyping(
    StopTypingEvent event,
    Emitter<IsTypingState> emit,
  ) async {
    await firebaseDataSource.updateTypingStatus(
        false, event.chat.chatId, event.userId);
    emit(
        IsTypingState(isTyping: false, chat: event.chat, userId: event.userId));
  }

  void updateIsTyping(bool value) {
    add(TypingChanged(isTyping: value));
  }
}

/* 

class MyBloc extends Bloc<MyEvent, MyState> {
  StreamSubscription<DocumentSnapshot> _chatSubscription;

  @override
  Stream<MyState> mapEventToState(MyEvent event) async* {
    if (event is StartListeningToChat) {
      final reference =
          FirebaseFirestore.instance.collection('chats').doc(event.chatId);

      // Cancel any existing subscription before creating a new one
      await _chatSubscription?.cancel();

      _chatSubscription = reference.snapshots().listen((querySnapshot) {
        print(querySnapshot.get("partnerIsTyping") as bool);
        add(ChatUpdated(isPartnerTyping: querySnapshot.get("partnerIsTyping") as bool));
      });
    } else if (event is ChatUpdated) {
      yield state.copyWith(isTyping: event.isPartnerTyping);
    }
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
 */