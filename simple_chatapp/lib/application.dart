import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/application/bloc/application_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/core/constants.dart';
import 'package:start/registry.dart';

class Application extends StatelessWidget {
  final Widget startPage;
  const Application({super.key, required this.startPage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => registry.get<ApplicationBloc>(),
        ),
        BlocProvider(
          create: (context) => registry.get<ChatBloc>(),
        ),
      ],
      child: MaterialApp(
        title: kApplicationName,
        home: SafeArea(child: startPage),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
