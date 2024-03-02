import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/models/chat_model.dart';

abstract class ChatRepository{

  Future<ChatModel> getChatModel(String id);

  Future<bool> sendChatMessage(MessageEntity messageEntity);
  
}