import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/infrastructure/models/chat_model.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRemoteDatasource chatRemoteDatasource;

  ChatRepositoryImpl({required this.chatRemoteDatasource});

  @override
  Future<ChatModel> getChatModel(String id) async {
    return await chatRemoteDatasource.getChatModel(id);
  }

  @override
  Future<bool> sendChatMessage(MessageEntity messageEntity) async {
    return await chatRemoteDatasource.sendChatMessage(messageEntity);
  }
}
