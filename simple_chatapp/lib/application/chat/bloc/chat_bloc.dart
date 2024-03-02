import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';
import 'package:start/domain/usecases/sendmessage/send_chat_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  LoadChatUsecase chatUsecase;
  SendChatMessageUsecase sendChatMessageUsecse;

  late UserEntity userEntity;

  ChatBloc({required this.chatUsecase, required this.sendChatMessageUsecse})
      : super(
          ChatInitial(
            userEntity: UserEntity(name: 'Hanna', userId: '100123'),
          ),
        ) {
    on<SetChatpartner>((state, emit) async {
      userEntity = state.chatPartner;
    });
    on<LoadChat>((state, emit) async {
      userEntity.chat = await chatUsecase.loadChatByUserId(userEntity.userId);
      if (kDebugMode) {
        await Future.delayed(
          const Duration(seconds: 0),
        );
      }
      emit(ChatLoaded(userEntity: userEntity));
    });

    on<SendChatMessage>((state, emit) async {
      await sendChatMessageUsecse.sendChatMessage(state.messageEntity);
    });
  }
}
