import 'package:start/domain/entities/message_entity.dart';

class Test {
  static late List<MessageEntity> messages;

  Test() {
    messages = [];
    /* messages.addAll([
      MessageEntity(
        ownerId: "101",
        text: '1',
        creationDate: DateTime.now().subtract(const Duration(days: 1)),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text: '1_2',
        creationDate: DateTime.now().subtract(const Duration(days: 2)),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: '2',
        creationDate: DateTime.now().subtract(const Duration(days: 3)),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text: '3',
        creationDate: DateTime.now().subtract(const Duration(days: 4)),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: 'First message',
        creationDate: DateTime.now().subtract(const Duration(days: 5)),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text: '4',
        creationDate: DateTime.now().subtract(const Duration(days: 6)),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: '5',
        creationDate: DateTime.now().subtract(const Duration(days: 8)),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text: '6',
        creationDate: DateTime.now().subtract(const Duration(days: 9)),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: 'F7',
        creationDate: DateTime.now().subtract(const Duration(days: 1)),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text: 'Second messag8',
        creationDate: DateTime.now().subtract(const Duration(days: 10)),
      )..sendFromMe = true,
      MessageEntity(
        ownerId: "101",
        text: '9',
        creationDate: DateTime.now().subtract(const Duration(days: 11)),
      )..sendFromMe = false,
      MessageEntity(
        ownerId: me.userId,
        text: '10',
        creationDate: DateTime.now().subtract(const Duration(days: 2)),
      )..sendFromMe = true,
    ]); */
  }
}
