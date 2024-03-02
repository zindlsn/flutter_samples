import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

class LoadChatUsecase {
  ChatRepository chatRepository;

  LoadChatUsecase({required this.chatRepository});

  Future<ChatEntity> loadChatByUserId(String id) async {
    return await chatRepository.getChatModel(id);
  }
}
