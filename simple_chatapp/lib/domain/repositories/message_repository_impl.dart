import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatMessageRepository {
  MessageDatasource chatRemoteDatasource;
  FirebaseDataSource firebaseDataSource;

  ChatRepositoryImpl(
      {required this.chatRemoteDatasource, required this.firebaseDataSource});

  @override
  Future<List<MessageEntity>> loadMessagesByChatId(String id) async {
    return await firebaseDataSource.loadMessagesByChatId(id);
  }

  @override
  Future<bool> sendChatMessage(MessageEntity messageEntity) async {
    return await chatRemoteDatasource.sendMessage(messageEntity);
  }

  @override
  Future<List<MessageEntity>> loadMoreMessagesByUserId(
      int lastIndex, int count, String id) async {
    List<MessageEntity> loadedMessages = await chatRemoteDatasource
        .loadMoreMessagesByUserId(lastIndex, count, id);
    loadedMessages.sort();
    return Future.value(loadedMessages);
  }
}
