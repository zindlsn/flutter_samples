import 'package:flutter/foundation.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/models/chat_model.dart';
import 'package:start/main.dart';

abstract class ChatRemoteDatasource {
  Future<ChatModel> getChatModel(String id);

  Future<bool> sendChatMessage(MessageEntity messageEntity);
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  List<MessageEntity> messages = [];
  @override
  Future<ChatModel> getChatModel(String id) {
    String id1 = '101';
    if (kDebugMode) {
      messages.addAll([
        MessageEntity(
          ownerId: id1,
          text: 'First message',
          sentTime: DateTime.now(),
        )..sendFromMe = false,
        MessageEntity(
          ownerId: me.userId,
          text:
              'Second message which is very long, and so an and so an... a.sd fasd fs.',
          sentTime: DateTime.now(),
        )..sendFromMe = true
      ]);
    }
    ChatModel model1 = ChatModel(messages: messages);
    return Future.value(model1);
  }

  @override
  Future<bool> sendChatMessage(MessageEntity messageEntity) {
    messages.add(messageEntity);
    return Future.value(true);
  }
}
