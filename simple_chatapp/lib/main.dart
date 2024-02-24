import 'package:flutter/material.dart';
import 'package:start/application.dart';
import 'package:start/presentation/chatpage/chat_page.dart';

void main() {
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
