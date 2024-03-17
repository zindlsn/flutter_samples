import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';
import 'package:start/main.dart';

import 'load_chat_usecase_test.mocks.dart';

@GenerateMocks([LoadChatMessageUsecase])
void main() {
  group('LoadChatUsecase', () {
    List<MessageEntity> messagesOnTheServer = [];
    final today = DateTime(2024, 3, 10);
    const chatPartnerId = "101";

    setUp(() => {
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
      final mockUsecase = MockLoadChatMessageUsecase();

      when(mockUsecase.loadMoreMessagesByUserId(
              id: chatPartnerId, startIndex: 0, count: 1))
          .thenAnswer((_) async => [messagesOnTheServer.first]);

      // Act
      final result = await mockUsecase.loadMoreMessagesByUserId(
          id: chatPartnerId, startIndex: 0, count: 1);

      // Assert
      verify(mockUsecase.loadMoreMessagesByUserId(
              id: chatPartnerId, startIndex: 0, count: 1))
          .called(1);
      expect(result, isA<List<MessageEntity>>());
      expect(result.length, 1);
      expect(result[0].text, '1');
      expect(result[0].creationDate, today);
      expect(result[0].sendFromMe, false);
    });

    test('should load two message by userId', () async {
      // Arrange
      final mockUsecase = MockLoadChatMessageUsecase();

      when(mockUsecase.loadMoreMessagesByUserId(
              id: chatPartnerId, startIndex: 0, count: 2))
          .thenAnswer((_) async {
        return Future<List<MessageEntity>>.value(
            messagesOnTheServer.sublist(0, 2));
      });

      // Act
      final result = await mockUsecase.loadMoreMessagesByUserId(
          id: chatPartnerId, startIndex: 0, count: 2);

      // Assert
      verify(mockUsecase.loadMoreMessagesByUserId(
              id: chatPartnerId, startIndex: 0, count: 2))
          .called(1);
      expect(result, isA<List<MessageEntity>>());
      expect(result.length, 2);
      expect(result[0].text, '1');
      expect(result[0].creationDate, today);
      expect(result[0].sendFromMe, false);
      expect(result[1].text, '1_2');
    });

    test('should load two message and after that two more messages by userId',
        () async {
      // Arrange
      final mockUsecase = MockLoadChatMessageUsecase();

      List<MessageEntity> loadedMessages = [];

      when(mockUsecase.loadMoreMessagesByUserId(
              id: chatPartnerId, startIndex: 0, count: 2))
          .thenAnswer((_) async {
        return Future<List<MessageEntity>>.value(
            messagesOnTheServer.sublist(0, 2));
      });

      // Act
      final result = await mockUsecase.loadMoreMessagesByUserId(
          id: chatPartnerId, startIndex: 0, count: 2);

      loadedMessages.addAll(result);

      // Assert
      verify(mockUsecase.loadMoreMessagesByUserId(
              id: chatPartnerId, startIndex: 0, count: 2))
          .called(1);
      expect(result, isA<List<MessageEntity>>());
      expect(result.length, 2);
      expect(loadedMessages.length, 2);
      expect(result[0].text, '1');
      expect(result[0].creationDate, today);
      expect(result[0].sendFromMe, false);
      expect(result[1].text, '1_2');

      when(mockUsecase.loadMoreMessagesByUserId(
              id: chatPartnerId, startIndex: 2, count: 2))
          .thenAnswer((_) async {
        return Future<List<MessageEntity>>.value(
            messagesOnTheServer.sublist(2, 4));
      });

      // Act
      final result2 = await mockUsecase.loadMoreMessagesByUserId(
          id: chatPartnerId, startIndex: 2, count: 2);

      // Assert
      verify(mockUsecase.loadMoreMessagesByUserId(
              id: chatPartnerId, startIndex: 2, count: 2))
          .called(1);
      loadedMessages.addAll(result2);
      expect(result, isA<List<MessageEntity>>());
      expect(result2.length, 2);
      expect(loadedMessages.length, 4);

      /*expect(result[0].text, '1');
      expect(result[0].creationDate, today);
      expect(result[0].sendFromMe, false);
      expect(result[1].text, '1_2'); */
    });
  });
}
