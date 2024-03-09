import 'package:flutter/foundation.dart';
import 'package:start/core/server.dart';
import 'package:start/domain/entities/message_entity.dart';

abstract class MessageDatasource {
  Future<List<MessageEntity>> loadMessagesByUserId(String id);

  Future<bool> sendMessage(MessageEntity messageEntity);
}



class MessageDatasourceImpl implements MessageDatasource {
  @override
  Future<List<MessageEntity>> loadMessagesByUserId(String id) {
    if (kDebugMode) {}
    return Future.value(Test.messages);
  }

  @override
  Future<bool> sendMessage(MessageEntity messageEntity) {
    Test.messages.add(messageEntity);
    return Future.value(true);
  }
}
