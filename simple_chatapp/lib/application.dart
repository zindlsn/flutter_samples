import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:start/application/application/bloc/application_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/messages/bloc/messages_bloc.dart';
import 'package:start/application/chatlist/bloc/chat_list_bloc.dart';
import 'package:start/application/typing/bloc/typing_bloc.dart';
import 'package:start/core/constants.dart';

class Application extends StatelessWidget {
  final Widget entryPage;
  const Application({super.key, required this.entryPage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<ApplicationBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<ChatBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<ChatListBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<MessagesBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I.get<TypingBloc>(),
        ),
      ],
      child: MaterialApp(
        title: kApplicationName,
        home: SafeArea(child: entryPage),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
