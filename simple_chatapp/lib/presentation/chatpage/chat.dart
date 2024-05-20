import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/typing/bloc/typing_bloc.dart';
import 'package:start/core/exexptions/string_extension.dart';
import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/main.dart';
import 'package:start/presentation/chatpage/telegram/widgets/message_layout.dart';
import 'package:start/presentation/chatpage/telegram/widgets/send_message_element.dart';

class ChatPage extends StatelessWidget {
  final ChatEntity chatPartner;
  const ChatPage({super.key, required this.chatPartner});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TypingBloc>(context).add(
      TypingListeningInit(chatId: chatPartner.chatId),
    );
    BlocProvider.of<ChatBloc>(context).add(
      LoadChat(chatId: chatPartner.chatId),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(chatPartner.name),
      ),
      body: Column(
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
          BlocBuilder<TypingBloc, TypingState>(
            builder: (context, state) {
              if (state is IsTypingState) {
                return const Text("Is Typing...");
              }
              return Text(StringExtension.empty);
            },
          ),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return SendMessageElement(chatId: chatPartner.chatId);
            },
          ),
        ],
      ),
    );
  }
}
