import 'package:start/domain/entities/message_entity.dart';

abstract class ChatMessageRepository {
  Future<List<MessageEntity>> loadMessages(String id);
  Future<List<MessageEntity>> loadMoreMessagesByUserId(
      int lastIndex, int count, String id);
  Future<bool> sendChatMessage(MessageEntity messageEntity);
}
