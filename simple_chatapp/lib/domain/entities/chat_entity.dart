import 'dart:typed_data';

import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

///
/// Represents a the chatpartner
///
class ChatRoomEntity {
  late String id;
  List<MessageEntity> messages;
  String chatRoomId;
  String name;
  Uint8List? chatRoomProfileImage;
  List<ParticipantEntity> participants = [];
  late ParticipantEntity me;

  ChatRoomEntity(
      {required this.messages, required this.chatRoomId, required this.name}) {
    id = const Uuid().v4();
  }
}
