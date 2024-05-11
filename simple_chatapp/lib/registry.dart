import 'package:get_it/get_it.dart';
import 'package:start/application/application/bloc/application_bloc.dart';
import 'package:start/application/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';
import 'package:start/domain/repositories/message_repository_impl.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';
import 'package:start/domain/usecases/sendmessage/send_chat_message.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

late GetIt registry = GetIt.instance;

void init() {
  initDatasourcesProduction();
  initRepositories();
  initUsecaes();
  initBlocs();
}

void initUsecaes() {
  registry.registerLazySingleton(
      () => LoadChatMessageUsecase(chatRepository: registry()));
  registry.registerLazySingleton(() => FirebaseDataSource());
  registry.registerLazySingleton(
      () => SendChatMessageUsecase(chatRepository: registry()));
}

void initDatasourcesProduction() {
  registry
      .registerLazySingleton<MessageDatasource>(() => MessageDatasourceImpl());
}

void initRepositories() {
  registry.registerLazySingleton<ChatMessageRepository>(() =>
      ChatRepositoryImpl(
          chatRemoteDatasource: registry(), firebaseDataSource: registry()));
}

void initBlocs() {
  registry.registerFactory(() => ApplicationBloc());
  registry.registerFactory(() => ChatBloc());
  registry.registerFactory(() => MessagesBloc(
      loadChatUsecase: registry(),
      sendChatMessageUsecase: registry(),
      firebaseDataSource: registry()));
}
