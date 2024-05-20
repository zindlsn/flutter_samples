import 'package:start/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel(
      {required super.messages, required super.chatId, required super.name});
}
