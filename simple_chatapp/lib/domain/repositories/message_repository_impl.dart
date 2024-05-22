import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

class ChatRepositoryImplOld implements ChatMessageRepository {
  final MessageDatasource _chatRemoteDatasource;
  final FirebaseDataSource _firebaseDataSource;

  late List<ChatEntity> chats;

  ChatRepositoryImplOld(
      {required MessageDatasource chatRemoteDatasource, required FirebaseDataSource firebaseDataSource}) : _firebaseDataSource = firebaseDataSource, _chatRemoteDatasource = chatRemoteDatasource;

  @override
  Future<List<MessageEntity>> loadMessagesByChatId(String chatId) async {
    return await _firebaseDataSource.loadMessagesByChatId(chatId);
  }

  @override
  Future<bool> sendChatMessage(MessageEntity messageEntity) async {
    return await _chatRemoteDatasource.sendMessage(messageEntity);
  }

  @override
  Future<List<MessageEntity>> loadMoreMessagesByUserId(
      int lastIndex, int count, String id) async {
    List<MessageEntity> loadedMessages = await _chatRemoteDatasource
        .loadMoreMessagesByUserId(lastIndex, count, id);
    loadedMessages.sort();
    return Future.value(loadedMessages);
  }
}
