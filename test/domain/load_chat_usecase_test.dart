import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';

import 'load_chat_usecase_test.mocks.dart';

@GenerateMocks([LoadChatUsecase])
void main() {
  group('LoadChatUsecase', () {
    test('should load chat by chat partner id', () async {
      // Arrange
      final mockUsecase = MockLoadChatUsecase();
      const chatPartnerId = "101";

      // Set up the mock behavior
      when(mockUsecase.loadChatByUserId(chatPartnerId)).thenAnswer(
          (_) async => ChatEntity(messages: [
                MessageEntity(
                    ownerId: chatPartnerId, text: "Here we go", sentTime: DateTime.now())
              ]));

      // Act
      final result = await mockUsecase.loadChatByUserId(chatPartnerId);

      // Assert
      verify(mockUsecase.loadChatByUserId(chatPartnerId)).called(1);
      expect(result, isA<ChatEntity>());
      expect(result.messages.length, 1);
      expect(result.messages[0].ownerId, chatPartnerId);
      expect(result.messages[0].text, "Here we go");
      expect(result.messages[0].sentTime, isA<DateTime>());
    });
  });
}
