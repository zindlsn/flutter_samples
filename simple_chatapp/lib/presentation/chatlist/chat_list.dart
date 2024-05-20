import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/chatlist/bloc/chat_list_bloc.dart';
import 'package:start/presentation/chatpage/chat.dart';

/// Displays all [ChatEntity] partners
class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatListBloc>(context).add(LoadChatList());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state is ChatListLoaded) {
            return GestureDetector(
              onTap: () {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatPage(chatPartner: state.chats.first),
                    ),
                  );
                }
              },
              child: ListTile(
                title: Text(state.chats.first.name),
              ),
            );
          }
          return const Text('No conversations yet');
        },
      ),
    );
  }
}
