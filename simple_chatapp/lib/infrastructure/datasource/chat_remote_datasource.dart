import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:start/core/server.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/models/chat_model.dart';

abstract class MessageDatasource {
  Future<List<MessageEntity>> loadAllMessagesByUserId(String id);
  Future<List<MessageEntity>> loadMoreMessagesByUserId(
      int lastIndex, int count, String id);

  Future<bool> sendMessage(MessageEntity messageEntity);
}

class MessageDatasourceImpl implements MessageDatasource {
  List<MessageEntity> messages = [];
  MessageDatasourceImpl() {
    Test();
    messages = Test.messages;
  }
  @override
  Future<List<MessageEntity>> loadAllMessagesByUserId(String id) {
    if (kDebugMode) {}
    return Future.value(messages);
  }

  @override
  Future<bool> sendMessage(MessageEntity messageEntity) {
    messages.add(messageEntity);
    return Future.value(true);
  }

  @override
  Future<List<MessageEntity>> loadMoreMessagesByUserId(
      int lastIndex, int count, String id) {
    List<MessageEntity> messages = Test.messages;
    int lastMessageId = messages.length - 1;
    int lastId = min((lastIndex + count), lastMessageId);
    return Future.value(messages.sublist(lastIndex, lastId));
  }
}
