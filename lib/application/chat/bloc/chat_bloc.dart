import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  LoadChatUsecase chatUsecase;

  ChatBloc({required this.chatUsecase})
      : super(
          ChatInitial(
            userEntity: UserEntity(name: 'Hanna', userId: '100123'),
          ),
        ) {
    on<LoadChat>((state, emit) async {
      state.userEntity.chat =
          await chatUsecase.loadChatByUserId(state.userEntity.userId);

      if (kDebugMode) {
        await Future.delayed(
          const Duration(seconds: 4),
        );
      }

      emit(ChatLoaded(userEntity: state.userEntity));
    });
  }
}
