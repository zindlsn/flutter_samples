import 'package:flutter/material.dart';
import 'package:start/application.dart';
import 'package:start/presentation/chatpage/chat.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/registry.dart';

UserEntity me = UserEntity(userId: '11', name: 'Stefan');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApplication();
  runApp(
    const Application(
      entryPage: ChatPage(),
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
