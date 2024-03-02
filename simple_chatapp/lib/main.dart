import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:start/application.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/presentation/chatpage/telegram/chat_page.dart';
import 'package:start/registry.dart';

UserEntity me = UserEntity(userId: '11', name: 'Stefan');

void main() {
  init(getIt: GetIt.instance);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const Application(
      startPage: ChatPage(),
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
