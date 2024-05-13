import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/main.dart';

part 'typing_event.dart';
part 'typing_state.dart';

class TypingBloc extends Bloc<TypingEvent, TypingState> {
  FirebaseDataSource firebaseDataSource;

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
  }

  @override
  Stream<TypingState> mapEventToState(TypingEvent event) async* {
    if (event is TypingChanged) {
      yield TypingState(isTyping: event.isTyping);
    }
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
