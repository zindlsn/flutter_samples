import 'dart:typed_data';

import 'package:start/domain/entities/message_entity.dart';
import 'package:uuid/uuid.dart';

///
/// Represents a the chatpartner
///
class ChatEntity {
  late String id;
  List<MessageEntity> messages;
  String chatId;
  String name;
  Uint8List? profileImage;

  ChatEntity(
      {required this.messages, required this.chatId, required this.name}) {
    id = const Uuid().v4();
  }
}
