import 'package:start/domain/entities/message_entity.dart';
import 'package:start/main.dart';

class Test {
  static late List<MessageEntity> messages;

  Test() {
    messages = [];
    messages.addAll([
      MessageEntity(
        ownerId: "101",
        text: 'First message',
        sentTime: DateTime.now(),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text:
            'Second message which is very long, and so an and so an... a.sd fasd fs.',
        sentTime: DateTime.now(),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: 'First message',
        sentTime: DateTime.now(),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text:
            'Second message which is very long, and so an and so an... a.sd fasd fs.',
        sentTime: DateTime.now(),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: 'First message',
        sentTime: DateTime.now(),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text:
            'Second message which is very long, and so an and so an... a.sd fasd fs.',
        sentTime: DateTime.now(),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: 'First message',
        sentTime: DateTime.now(),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text:
            'Second message which is very long, and so an and so an... a.sd fasd fs.',
        sentTime: DateTime.now(),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: 'First message',
        sentTime: DateTime.now(),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text:
            'Second message which is very long, and so an and so an... a.sd fasd fs.',
        sentTime: DateTime.now(),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: 'First message',
        sentTime: DateTime.now(),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text:
            'Second message which is very long, and so an and so an... a.sd fasd fs.',
        sentTime: DateTime.now(),
      )..sendFromMe = true,
    ]);
  }
}
