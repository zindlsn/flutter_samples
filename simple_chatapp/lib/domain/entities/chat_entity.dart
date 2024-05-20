import 'package:start/domain/entities/message_entity.dart';

///
/// Represents a the chatpartner
///
class ChatEntity {
  List<MessageEntity> messages;
  String chatId;
  String name;

  ChatEntity(
      {required this.messages, required this.chatId, required this.name});
}
