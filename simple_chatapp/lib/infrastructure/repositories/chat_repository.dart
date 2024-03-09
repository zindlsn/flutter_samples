import 'package:start/domain/entities/message_entity.dart';

abstract class ChatMessageRepository{

  Future<List<MessageEntity>> loadMessages(String id);

  Future<bool> sendChatMessage(MessageEntity messageEntity);
  
}