import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/auth/bloc/auth_bloc.dart';
import 'package:start/presentation/chatlist/chat_list.dart';
import 'package:start/presentation/login/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AuthInitEvent());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => LoginPage(),
            ),
          );
        } else if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const ChatList(),
            ),
          );
        }
      },
      builder: (context, state) {
        return const Placeholder();
      },
    );
  }
}
