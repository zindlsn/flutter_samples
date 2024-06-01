import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/typing/bloc/typing_bloc.dart';
import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/main.dart';
import 'package:start/presentation/chatpage/telegram/widgets/message_layout.dart';
import 'package:start/presentation/chatpage/telegram/widgets/send_message_element.dart';

class ChatPage extends StatelessWidget {
  final ChatRoomEntity chatPartner;
  const ChatPage({super.key, required this.chatPartner});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TypingBloc>(context).add(
      TypingListeningInit(
          chatId: chatPartner.chatRoomId, chat: chatPartner, userId: me.userId),
    );
    BlocProvider.of<ChatBloc>(context).add(
      LoadChat(chat: chatPartner),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(chatPartner.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoadedFailed) {
                return const Center(
                    child: Text('Messages could not be loaded. Try again'));
              } else if (state is ChatLoaded) {
                List<MessageEntity> messages = state.loadedMessages;
                return Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      MessageEntity message = messages[index];
                      if (message.sendFromMe) {
                        return OutBubble(message: message);
                      } else {
                        return InBubble(message: message);
                      }
                    },
                  ),
                );
              }
              return const Align(
                alignment: Alignment.bottomLeft,
                child: Text('No messages yet'),
              );
            },
          ),
          BlocBuilder<TypingBloc, TypingState>(builder: (context, state) {
            if (state is IsTypingState) {
              if (state.isTyping) {
                return const Text("Is Typing...");
              } else {
                return const SizedBox.shrink();
              }
            } else {
              return const SizedBox.shrink();
            }
          }),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return SendMessageElement(chat: chatPartner);
            },
          ),
        ],
      ),
    );
  }
}
