import 'package:get_it/get_it.dart';
import 'package:start/application/application/bloc/application_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';
import 'package:start/application/typing/bloc/typing_bloc.dart';
import 'package:start/domain/repositories/message_repository_impl.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';
import 'package:start/domain/usecases/sendmessage/send_chat_message.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

GetIt registry = GetIt.instance;

/// initialize the application
Future<void> initApplication() async {
  _initDatasourcesProduction();
  _initRepositories();
  _initUsecaes();
  _initBlocs();
  await GetIt.instance.get<FirebaseDataSource>().init();
}

void _initUsecaes() {
  registry.registerLazySingleton(
      () => LoadChatMessageUsecase(chatRepository: registry()));
  registry.registerLazySingleton(() => FirebaseDataSource());
  registry.registerLazySingleton(
      () => SendChatMessageUsecase(chatRepository: registry()));
}

void _initDatasourcesProduction() {
  registry
      .registerLazySingleton<MessageDatasource>(() => MessageDatasourceImpl());
}

void _initRepositories() {
  registry.registerLazySingleton<ChatMessageRepository>(() =>
      ChatRepositoryImpl(
          chatRemoteDatasource: registry(), firebaseDataSource: registry()));
}

void _initBlocs() {
  registry.registerFactory(() => ApplicationBloc());
  registry.registerFactory(() => ChatBloc());
  registry.registerFactory(() => TypingBloc(firebaseDataSource: registry()));
  registry.registerFactory(() => MessagesBloc(
      loadChatUsecase: registry(),
      sendChatMessageUsecase: registry(),
      firebaseDataSource: registry()));
}
