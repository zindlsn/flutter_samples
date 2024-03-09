import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

class LoadChatMessageUsecase {
  ChatMessageRepository chatRepository;

  LoadChatMessageUsecase({required this.chatRepository});

  Future<List<MessageEntity>> loadChatByUserId({required String id}) async {
    return await chatRepository.loadMessages(id);
  }
}
