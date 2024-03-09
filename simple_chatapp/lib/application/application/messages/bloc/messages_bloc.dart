import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  List<String> messages = ["Test"];
  MessagesBloc() : super(MessagesInitial()) {
    on<SendMessage>((state, emit) {
      messages.add('Next message');
      emit(MessagesLoaded());
    });

    on<LoadMoreMessage>((state, emit) {
      messages.add('Next message from datasoruce');
      emit(MessagesLoaded());
    });
  }
}
