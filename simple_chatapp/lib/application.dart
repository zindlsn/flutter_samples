import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/application/bloc/application_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/core/constants.dart';
import 'package:start/domain/usecases/loadchat/load_chat_usecase.dart';

class Application extends StatelessWidget {
  final Widget startPage;
  const Application({super.key, required this.startPage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApplicationBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(chatUsecase: LoadChatUsecase()),
        ),
      ],
      child: MaterialApp(
        title: kApplicationName,
        home: SafeArea(child: startPage),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
      ),
    );
  }
}
