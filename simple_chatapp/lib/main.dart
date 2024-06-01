import 'package:flutter/material.dart';
import 'package:start/application.dart';
import 'package:start/firebase_options.dart';
import 'package:start/presentation/chatlist/chat_list.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/registry.dart';
import 'package:firebase_core/firebase_core.dart';

ParticipantEntity me = ParticipantEntity(username: 'stefan');
ParticipantEntity hannah = ParticipantEntity(username: 'Hannah');
ParticipantEntity cori = ParticipantEntity(username: 'Cori');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initApplication();
  runApp(
    const Application(
      entryPage: ChatList(),
    ),
  );
}
