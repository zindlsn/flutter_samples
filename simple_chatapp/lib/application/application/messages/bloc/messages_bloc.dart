import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';
import 'package:start/domain/usecases/sendmessage/send_chat_message.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/main.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  LoadChatMessageUsecase loadChatUsecase;
  SendChatMessageUsecase sendChatMessageUsecase;
  FirebaseDataSource firebaseDataSource;
  Timer? _timer;
  int _secondsRemaining = 5;
  List<MessageEntity> messages = [];
  MessagesBloc(
      {required this.loadChatUsecase,
      required this.sendChatMessageUsecase,
      required this.firebaseDataSource})
      : super(MessagesState.initial()) {
    on<LoadMoreMessage>((state, emit) async {
      emit(MessageLoading(messages: [], isTyping: false));
      await Future.delayed(const Duration(seconds: 4));
      //state.copyWith(isTyping: false);
      try {
        await Future.delayed(
          const Duration(seconds: 2),
        );
        messages = [];
        messages.addAll(
          await loadChatUsecase.loadChatByUserId(id: "101"),
        );
      } on Exception {
        emit(FailureMessageLoaded(messages: [], isTyping: false));
      }
      emit(MessagesLoaded(messages: [], isTyping: false));
    });

    on<MessagesInitial>((state, emit) {
      Tuple2<bool, String?>? result =
          firebaseDataSource.subscribeToTypingStatus();
      emit(const MessagesState(
          messages: [], isTyping: true, typingUserId: "not me"));
    });

    on<SendMessage>((state, emit) {
      sendChatMessageUsecase.sendChatMessage(
        MessageEntity(
          ownerId: me.userId,
          text: state.text,
          chatId: "202",
          sendFromMe: true,
          creationDate: DateTime.now().add(
            const Duration(seconds: 20),
          ),
        )..sendFromMe = true,
      );
    });

    on<StartTypingEvent>(_onStartTyping);
    on<StopTypingEvent>(_onStopTyping);
    on<SubscribeToMessagesEvent>(_onSubscribeToMessages);
    on<SubscribeToTypingEvent>(_onSubscribeToTyping);
  }

  Future<void> _onStartTyping(
    StartTypingEvent event,
    Emitter<MessagesState> emit,
  ) async {
    _timer?.cancel();
    _secsRemaining = 2;
    await firebaseDataSource.updateTypingStatus(true, event.userId);
    emit(state.copyWith(isTyping: true, typingUserId: event.userId));
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
      } else {
        timer.cancel();
        await firebaseDataSource.updateTypingStatus(false, event.userId);
      }
    });
  }

  int _secsRemaining = 2;

  Future<void> _onStopTyping(
    StopTypingEvent event,
    Emitter<MessagesState> emit,
  ) async {
    await firebaseDataSource.updateTypingStatus(false, event.userId);
    emit(state.copyWith(isTyping: false, typingUserId: null));
  }

  Future<void> _onSubscribeToMessages(
    SubscribeToMessagesEvent event,
    Emitter<MessagesState> emit,
  ) async {
    var messages = firebaseDataSource.subscribeToMessages();
    emit(
      MessagesState(messages: messages, isTyping: false),
    );
  }

  Future<void> _onSubscribeToTyping(
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
  }
}
