import 'package:flutter/material.dart';
import 'package:start/application.dart';
import 'package:start/presentation/chatlist/chat_list.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/registry.dart';

UserEntity me = UserEntity(userId: '11', name: 'Stefan');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApplication();
  runApp(
    const Application(
      entryPage: ChatList(),
    ),
  );
}