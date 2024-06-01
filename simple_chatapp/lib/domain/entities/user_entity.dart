import 'package:uuid/uuid.dart';
import 'package:start/domain/entities/chat_entity.dart';

class ParticipantEntity {
  late String userId;
  String? referenceDocument;
  String username;
  late ChatRoomEntity chat;

  ParticipantEntity({required this.username}) {
    var uuid = const Uuid();
    userId = uuid.v4();
  }
}
