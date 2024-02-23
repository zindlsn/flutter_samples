import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/bloc/application_bloc.dart';
import 'package:start/core/constants.dart';

class Application extends StatelessWidget {
  final Widget start;
  const Application({super.key, required this.start});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApplicationBloc(),
        ),
      ],
      child: MaterialApp(
        title: kApplicationName,
        home: SafeArea(child: start),
        theme: ThemeData.light(useMaterial3: true),
      ),
    );
  }
}
