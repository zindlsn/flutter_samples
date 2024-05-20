import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';

part 'typing_event.dart';
part 'typing_state.dart';

class TypingBloc extends Bloc<TypingEvent, TypingState> {
  FirebaseDataSource firebaseDataSource;
  Timer? _timer;
  int _secondsRemaining = 5;
  TypingBloc({required this.firebaseDataSource})
      : super(TypingState(isTyping: false)) {
    on<TypingListeningInit>((event, emit) async {
      try {
        Stream<DocumentSnapshot<Map<String, dynamic>>> chatStream =
            firebaseDataSource.firestore
                .collection('chats')
                .doc(event.chatId)
                .snapshots();

        /*  chatStream.listen((chat) async {
          var chatData = chat.data();
          bool isTyping = chatData!['partnerIsTyping'] as bool;
          await Future.delayed(const Duration(seconds: 2));
        }); */

        DocumentReference reference =
            FirebaseFirestore.instance.collection('chats').doc(event.chatId);
        reference.snapshots().listen((querySnapshot) async {
          if (kDebugMode) {
            //  print("Printed:" + querySnapshot.get("partnerIsTyping"));
          }
          //  emit(IsTypingState(isTyping: false));
          //  await emitState(event, emit, querySnapshot);
        });
/*
        DocumentSnapshot<Map<String, dynamic>> chat = await firebaseDataSource
            .firestore
            .collection('chats')
            .doc("V5QCuwyF5ddv9GCzlCBQ")
            .get();

        var chatData = chat.data();
        bool isTyping = chatData!['partnerIsTyping'] as bool;
        await for (var snapshot
            in firebaseDataSource.firestore.collection('chats').snapshots()) {
          final result = snapshot.docs.map((doc) {
            final data = doc.data();
            return Tuple2(data['isTyping'] as bool, data['userId'] as String);
          }).first;
          isTyping = result.item1;
          emit(
            state.copyWith(isTyping: isTyping),
          );
        } */
      } catch (e) {
        print(e);
      }
    });
    on<StartTypingEvent>(_onStartTyping);
    on<StopTypingEvent>(_onStopTyping);
    on<TypingChanged>((event, emit) {
      emit(TypingState(isTyping: event.isTyping));
    });
  }
  int _secsRemaining = 2;
  bool _storeIsTyping = false;

  Future<void> emitState(TypingListeningInit event, Emitter<TypingState> emit,
      DocumentSnapshot<Object?> querySnapshot) async {
    await Future.microtask(() => emit(state.copyWith(
        isTyping: querySnapshot.get("partnerIsTyping") as bool)));
  }

  Future<void> _onStartTyping(
    StartTypingEvent event,
    Emitter<TypingState> emit,
  ) async {
    _timer?.cancel();
    _secsRemaining = 2;

    if (!_storeIsTyping) {
      _storeIsTyping =
          await firebaseDataSource.updateTypingStatus(true, event.userId);
    }
    emit(state.copyWith(isTyping: true));
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
      } else {
        timer.cancel();
        await firebaseDataSource.updateTypingStatus(false, event.userId);
        _storeIsTyping = false;
      }
    });
  }

  Future<void> _onStopTyping(
    StopTypingEvent event,
    Emitter<TypingState> emit,
  ) async {
    await firebaseDataSource.updateTypingStatus(false, event.userId);
    emit(state.copyWith(isTyping: false));
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