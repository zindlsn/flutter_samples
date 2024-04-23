import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:start/application.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/infrastructure/datasource/firebase_data_source.dart';
import 'package:start/presentation/chatpage/telegram/chat_screen.dart';
import 'package:start/registry.dart';

UserEntity me = UserEntity(userId: '11', name: 'Stefan');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await GetIt.instance.get<FirebaseDataSource>().init();
  await GetIt.instance.get<FirebaseDataSource>().createMessage(MessageEntity(
      ownerId: "101", text: "Hello World2", creationDate: DateTime.now(), sendFromMe: false,chatId: ""));

  runApp(
    const Application(
      startPage: ChatScreen(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Column(
        children: [
          Text('Test'),
        ],
      ),
    );
  }
}
