import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MessagesBloc>(context).add(LoadMoreMessage());
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<MessagesBloc, MessagesState>(
            builder: (context, state) {
              if (state is MessagesLoaded) {
                List<String> messages =
                    BlocProvider.of<MessagesBloc>(context).messages;
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: messages.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: ((context, index) {
                        return Text(messages[index]);
                      }),
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          const Spacer(),
          Center(
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                BlocProvider.of<MessagesBloc>(context)
                    .add(SendMessage(text: "New Message!!!"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
