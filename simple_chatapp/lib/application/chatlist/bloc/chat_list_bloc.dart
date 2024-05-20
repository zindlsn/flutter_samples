import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/infrastructure/repositories/chat_data_service.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatDataRepository dataSerivce =
      GetIt.instance.get<ChatDataRepository>();
  ChatListBloc() : super(ChatListInitial()) {
    on<LoadChatList>((event, emit) {
      emit(ChatListLoaded(chats: dataSerivce.chats));
    });
  }
}
