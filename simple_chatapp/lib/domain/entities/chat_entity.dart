import 'package:start/domain/entities/message_entity.dart';

///
///Represents a whoe chathistory
///
class ChatEntity {
  List<MessageEntity> messages;

  ChatEntity({required this.messages});
}
