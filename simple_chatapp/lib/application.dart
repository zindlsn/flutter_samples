import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:start/application/application/bloc/application_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';
import 'package:start/core/constants.dart';

class Application extends StatelessWidget {
  final Widget startPage;
  const Application({super.key, required this.startPage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I.get<ApplicationBloc>(),
        ),

                BlocProvider(
          create: (context) => GetIt.I.get<MessagesBloc>(),
       ),
      ],
      child: MaterialApp(
        title: kApplicationName,
        home: SafeArea(child: startPage),
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
