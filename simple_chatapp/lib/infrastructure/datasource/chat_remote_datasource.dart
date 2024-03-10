import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:start/core/server.dart';
import 'package:start/domain/entities/message_entity.dart';

abstract class MessageDatasource {
  Future<List<MessageEntity>> loadAllMessagesByUserId(String id);
  Future<List<MessageEntity>> loadMoreMessagesByUserId(
      int lastIndex, int count, String id);

  Future<bool> sendMessage(MessageEntity messageEntity);
}

class MessageDatasourceImpl implements MessageDatasource {
  @override
  Future<List<MessageEntity>> loadAllMessagesByUserId(String id) {
    if (kDebugMode) {}
    return Future.value(Test.messages);
  }

  @override
  Future<bool> sendMessage(MessageEntity messageEntity) {
    Test.messages.add(messageEntity);
    return Future.value(true);
  }

  @override
  Future<List<MessageEntity>> loadMoreMessagesByUserId(
      int lastIndex, int count, String id) {
    List<MessageEntity> messages = Test.messages;
    messages.sort();
    int lastMessageId = messages.length - 1;
    int lastId = min((lastIndex + count), lastMessageId);
    return Future.value(Test.messages.sublist(lastIndex + 1, lastId));
  }
}
