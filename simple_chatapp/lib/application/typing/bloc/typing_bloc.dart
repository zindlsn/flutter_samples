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
    on<TypingListeningInit>((event, emit) async {
      firebaseDataSource.subscribeToTypingStatus().listen((data) {
        add(ChangeIsTyping(event.chatId, event.chat, event.userId,
            isTyping: data.first.item1));
      });
    });
    on<StartTypingEvent>(_onStartTyping);
    on<StopTypingEvent>(_onStopTyping);
    on<ChangeIsTyping>((event, emit) async {
      if (event.isTyping) {
        emit(IsTypingState(
            isTyping: true, chat: event.chat, userId: event.userId));
      } else {
        emit(IsTypingState(
            isTyping: false, chat: event.chat, userId: event.userId));
      }
    });
  }

  bool _storeIsTyping = false;

  FutureOr<void> _onStartTyping(
    StartTypingEvent event,
    Emitter<TypingState> emit,
  ) async {
    _timer?.cancel();
    if (!_storeIsTyping) {
      _storeIsTyping = await firebaseDataSource.updateTypingStatus(
          true, event.chat.chatId, event.userId);
    }
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
    Emitter<TypingState> emit,
  ) async {
    await firebaseDataSource.updateTypingStatus(
        false, event.chat.chatId, event.userId);
  }

  void updateIsTyping(bool value) {
    add(TypingChanged(isTyping: value));
  }
}
