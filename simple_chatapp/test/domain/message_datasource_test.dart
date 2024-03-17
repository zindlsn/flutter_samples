import 'package:flutter_test/flutter_test.dart';
import 'package:start/core/server.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/main.dart';

void main() {
  group('LoadChatUsecase', () {
    List<MessageEntity> messagesOnTheServer = [];
    final today = DateTime(2024, 3, 10);
    const chatPartnerId = "101";

    setUp(() => {
          Test(),
          messagesOnTheServer.addAll([
            MessageEntity(
              ownerId: chatPartnerId,
              text: '1',
              creationDate: today.subtract(const Duration(days: 0)),
            )..sendFromMe = false,
            MessageEntity(
              ownerId: me.userId,
              text: '1_2',
              creationDate: today.subtract(const Duration(days: 2)),
            )..sendFromMe = true,
            MessageEntity(
              ownerId: chatPartnerId,
              text: '2',
              creationDate: today.subtract(const Duration(days: 3)),
            )..sendFromMe = false,
            MessageEntity(
              ownerId: me.userId,
              text: '3',
              creationDate: today.subtract(const Duration(days: 4)),
            )..sendFromMe = true,
            MessageEntity(
              ownerId: chatPartnerId,
              text: 'First message',
              creationDate: today.subtract(const Duration(days: 5)),
            )..sendFromMe = false,
            MessageEntity(
              ownerId: me.userId,
              text: '4',
              creationDate: today.subtract(const Duration(days: 6)),
            )..sendFromMe = true,
            MessageEntity(
              ownerId: chatPartnerId,
              text: '5',
              creationDate: today.subtract(const Duration(days: 8)),
            )..sendFromMe = false,
            MessageEntity(
              ownerId: me.userId,
              text: '6',
              creationDate: today.subtract(const Duration(days: 9)),
            )..sendFromMe = true,
            MessageEntity(
              ownerId: chatPartnerId,
              text: 'F7',
              creationDate: today.subtract(const Duration(days: 1)),
            )..sendFromMe = false,
            MessageEntity(
              ownerId: me.userId,
              text: 'Second messag8',
              creationDate: today.subtract(const Duration(days: 10)),
            )..sendFromMe = true,
            MessageEntity(
              ownerId: chatPartnerId,
              text: '9',
              creationDate: today.subtract(const Duration(days: 11)),
            )..sendFromMe = false,
            MessageEntity(
              ownerId: me.userId,
              text: '10',
              creationDate: today.subtract(const Duration(days: 2)),
            )..sendFromMe = true,
          ])
        });
    test('should load one message by userId', () async {
      // Arrange
      final MessageDatasource dataSource = MessageDatasourceImpl();

      List<MessageEntity> result =
          await dataSource.loadMoreMessagesByUserId(0, 2, "101");

      expect(result[0].text, Test.messages[0].text);

      List<MessageEntity> result2 =
          await dataSource.loadMoreMessagesByUserId(2, 2, "101");

      expect(result2[0].text, Test.messages[2].text);

      List<MessageEntity> result3 = await dataSource.loadMoreMessagesByUserId(
          Test.messages.length - 2, 2, "101");

      expect(result3.length, 1);
    });
  });
}
