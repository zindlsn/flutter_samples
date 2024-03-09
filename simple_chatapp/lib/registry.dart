import 'package:get_it/get_it.dart';
import 'package:start/application/application/bloc/application_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';
import 'package:start/domain/repositories/chat_repository_impl.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';
import 'package:start/domain/usecases/sendmessage/send_chat_message.dart';
import 'package:start/infrastructure/datasource/chat_remote_datasource.dart';
import 'package:start/infrastructure/repositories/chat_repository.dart';

late GetIt registry;

void init({required getIt}) {
  registry = getIt;
  initDatasourcesProduction();
  initRepositories();
  initUsecaes();
  initBlocs();
}

void initUsecaes() {
  registry
      .registerLazySingleton(() => LoadChatUsecase(chatRepository: registry()));
  registry
      .registerLazySingleton(() => SendChatMessageUsecase(chatRepository: registry()));
}

void initDatasourcesProduction() {
  registry.registerLazySingleton<ChatRemoteDatasource>(
      () => ChatRemoteDatasourceImpl());
}

void initRepositories() {
  registry.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(chatRemoteDatasource: registry()));
}

void initBlocs() {
  registry.registerFactory(() => ApplicationBloc());
  registry.registerFactory(() => MessagesBloc());
}
