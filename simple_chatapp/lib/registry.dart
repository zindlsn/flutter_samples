import 'package:get_it/get_it.dart';
import 'package:start/application/application/bloc/application_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/messages/bloc/messages_bloc.dart';
import 'package:start/application/chatlist/bloc/chat_list_bloc.dart';
import 'package:start/application/typing/bloc/typing_bloc.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';
import 'package:start/domain/usecases/sendmessage/send_chat_message.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/infrastructure/repositories/chat_data_service.dart';

GetIt registry = GetIt.instance;

/// initialize the application
Future<void> initApplication() async {
  _initDatasourcesProduction();
  _initRepositories();
  _initServices();
  _initUsecaes();
  _initBlocs();
  await GetIt.instance.get<FirebaseDataSource>().init();
}

void _initUsecaes() {
  registry.registerLazySingleton(
      () => LoadChatMessageUsecase(chatRepository: registry()));
  registry.registerLazySingleton(() => FirebaseDataSource());
  registry.registerLazySingleton(() => SendChatMessageUsecase());
}

void _initDatasourcesProduction() {
  registry
      .registerLazySingleton<MessageDatasource>(() => MessageDatasourceImpl());
}

void _initServices() {}

void _initRepositories() {
  registry.registerLazySingleton(() => ChatRepositoryImpl());
}

void _initBlocs() {
  registry.registerFactory(() => ApplicationBloc());
  registry.registerFactory(() => ChatListBloc());
  registry.registerFactory(() => ChatBloc());
  registry.registerFactory(() => TypingBloc(firebaseDataSource: registry()));
  registry.registerFactory(() => MessagesBloc(
      sendChatMessageUsecase: registry(), firebaseDataSource: registry()));
}
