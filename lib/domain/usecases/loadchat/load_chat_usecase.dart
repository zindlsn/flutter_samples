import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/domain/entities/message_entity.dart';

class LoadChatUsecase {

  Future<ChatEntity> loadChatByUserId(String id) {
    return Future.value(ChatEntity(messages: [
      MessageEntity(ownerId: "id", text: "Here we go", sentTime: DateTime.now())
    ]));
  }
}
