import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/typing/bloc/typing_bloc.dart';
import 'package:start/presentation/chatpage/telegram/widgets/send_message_element.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(InitChat());
    BlocProvider.of<ChatBloc>(context).add(LoadChat());
    BlocProvider.of<TypingBloc>(context).add(TypingListeningInit());
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.loadedMessages.length,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(state.loadedMessages[index].text);
                    },
                  ),
                );
              }
              return Container(child: Text('NO state'));
            },
          ),
          BlocBuilder<TypingBloc, TypingState>(
            builder: (context, state) {
              return Text(state.isTyping ? "Is Typing" : "Not typing");
            },
          ),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SendMessageElement(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
