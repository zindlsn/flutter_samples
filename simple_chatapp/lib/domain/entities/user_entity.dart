import 'package:uuid/uuid.dart';
import 'package:start/domain/entities/chat_entity.dart';

class UserEntity {
  late String userId;
  String? referenceDocument;
  String username;
  late ChatEntity chat;

  UserEntity({required this.username}) {
    var uuid = const Uuid();
    userId = uuid.v4();
  }
}
