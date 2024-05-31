import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:start/application.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/home/home.dart';
import 'package:start/registry.dart';

UserEntity me = UserEntity(userId: '11', name: 'Stefan');

void main() async {
  const firebaseConfig = {
    "apiKey": "AIzaSyCdVUj7bupKj4kpO4jwiKyjfJw7_F1JZbM",
    "authDomain": "simplechatapp-977fa.firebaseapp.com",
    "projectId": "simplechatapp-977fa",
    "storageBucket": "simplechatapp-977fa.appspot.com",
    "messagingSenderId": "563851166700",
    "appId": "1:563851166700:web:ada74079a62b3dc704b6c9",
    "measurementId": "G-ZS891E5VN2"
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCdVUj7bupKj4kpO4jwiKyjfJw7_F1JZbM",
          appId: "1:563851166700:web:ada74079a62b3dc704b6c9",
          messagingSenderId: "563851166700",
          projectId: "simplechatapp-977fa"));

  await initApplication();
  runApp(
    const Application(
      entryPage: HomePage(),
    ),
  );
}
