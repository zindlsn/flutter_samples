import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

class SendChatMessageUsecase {
  ChatMessageRepository chatRepository;

  SendChatMessageUsecase({required this.chatRepository});

  Future<bool> sendChatMessage(MessageEntity messageEntity) async {
    return await chatRepository.sendChatMessage(messageEntity);
  }
}
