import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/application/chat/bloc/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(InitChat());
    return Column(
      children: [
        BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoaded) {
              return Text(state.loadedMessages.length.toString());
            }
            return Container();
          },
        ),
        BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Column(
              children: [
                state.isTyping
                    ? const Column(
                        children: [
                          Text('Is typing!f'),
                        ],
                      )
                    : const Text('No Typing'),
                TextButton(
                    onPressed: () =>
                        {BlocProvider.of<ChatBloc>(context).add(LoadChat())},
                    child: const Text('Start Typing'))
              ],
            );
          },
        ),
      ],
    );
  }
}
