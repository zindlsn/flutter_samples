import 'package:start/domain/entities/chat_entity.dart';

class UserEntity {
  String userId;
  String? name;
  late ChatEntity chat;

  UserEntity({required this.userId, required this.name});
}
