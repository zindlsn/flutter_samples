import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatMessageRepository {
  MessageDatasource chatRemoteDatasource;

  ChatRepositoryImpl({required this.chatRemoteDatasource});

  @override
  Future<List<MessageEntity>> loadMessages(String id) async {
    return await chatRemoteDatasource.loadMessagesByUserId(id);
  }

  @override
  Future<bool> sendChatMessage(MessageEntity messageEntity) async {
    return await chatRemoteDatasource.sendMessage(messageEntity);
  }
}
