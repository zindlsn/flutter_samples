import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/chatlist/bloc/chat_list_bloc.dart';
import 'package:start/presentation/chatlist/chatpartner_list_element.dart';
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
            BlocProvider.of<ChatBloc>(context).add(
              LoadChat(chat: state.chats.first),
            );
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
              child: ChatPartnerListElement(chatPartner: state.chats.first),
            );
          }
          return const Text('No conversations yet');
        },
      ),
    );
  }
}
