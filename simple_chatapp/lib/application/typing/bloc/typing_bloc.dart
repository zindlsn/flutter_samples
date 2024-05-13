import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/main.dart';

part 'typing_event.dart';
part 'typing_state.dart';

class TypingBloc extends Bloc<TypingEvent, TypingState> {
  FirebaseDataSource firebaseDataSource;
  Timer? _timer;
  int _secondsRemaining = 5;
  TypingBloc({required this.firebaseDataSource})
      : super(TypingState(isTyping: false)) {
    on<TypingListeningInit>((event, emit) async {
      bool isTyping = false;
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
        emit(
          state.copyWith(isTyping: true),
        );
        // ignore: empty_catches
      } catch (e) {}
    });
    on<StartTypingEvent>(_onStartTyping);
    on<StopTypingEvent>(_onStopTyping);
    on<TypingChanged>((event, emit) {
      emit(TypingState(isTyping: event.isTyping));
    });
  }
  int _secsRemaining = 2;
  bool _storeIsTyping = false;

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

  Stream<TypingState> get typingStream => firebaseDataSource.firestore
          .collection('typing')
          .snapshots()
          .map((snapshot) {
        final typingUsers = snapshot.docs.map((doc) {
          final data = doc.data();
          return Tuple2(data['isTyping'] as bool, data['userId'] as String);
        }).toList();
        bool isTyping = false;
        for (var user in typingUsers) {
          if (user.item1 && user.item2 == me.userId) {
            isTyping = true;
            break;
          }
        }
        return TypingState(isTyping: isTyping);
      });
}
