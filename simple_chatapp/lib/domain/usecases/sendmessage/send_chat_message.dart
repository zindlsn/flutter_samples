import 'package:get_it/get_it.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';

class SendChatMessageUsecase {
  FirebaseDataSource messageRepository =
      GetIt.instance.get<FirebaseDataSource>();

  SendChatMessageUsecase();

  Future<bool> sendChatMessage(MessageEntity messageEntity) async {
    return await messageRepository.sendMessage(messageEntity);
  }
}
