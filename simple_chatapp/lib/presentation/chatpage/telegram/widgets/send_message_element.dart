import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/messages/bloc/messages_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/typing/bloc/typing_bloc.dart';
import 'package:start/core/exexptions/string_extension.dart';
import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/main.dart';

class SendMessageElement extends StatefulWidget {
  final ChatEntity chat;
  const SendMessageElement({super.key, required this.chat});

  @override
  State<SendMessageElement> createState() => _SendMessageElementState();
}

class _SendMessageElementState extends State<SendMessageElement> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        BlocProvider.of<TypingBloc>(context).add(StopTypingEvent(
            userId: me.userId, chatId: widget.chat.chatId, chat: widget.chat));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: _messageController,
        focusNode: _focusNode,
        onChanged: (text) {
          setState(() {
            BlocProvider.of<TypingBloc>(context).add(
              StartTypingEvent(
                  userId: me.userId,
                  chatId: widget.chat.chatId,
                  chat: widget.chat),
            );
          });
        },
        decoration: InputDecoration(
            fillColor: Colors.blue,
            suffixIcon: GestureDetector(
              onTap: _messageController.text.isNotEmpty
                  ? () {
                      BlocProvider.of<MessagesBloc>(context).add(
                        SendMessage(text: _messageController.text),
                      );
                      ChatEntity chat = widget.chat;
                      chat.messages.add(MessageEntity(
                        ownerId: me.userId,
                        text: _messageController.text,
                        chatId: "V5QCuwyF5ddv9GCzlCBQ",
                        sendFromMe: true,
                        creationDate: DateTime.now().add(
                          const Duration(seconds: 20),
                        ),
                      )..sendFromMe = true);
                      BlocProvider.of<ChatBloc>(context).add(
                        LoadChat(chat: chat),
                      );
                      _messageController.text = StringExtension.empty;
                      setState(() {});
                    }
                  : null,
              child: _messageController.text.isNotEmpty
                  ? const Icon(
                      Icons.send,
                      color: Colors.blue,
                    )
                  : const Icon(
                      Icons.send,
                      color: Colors.grey,
                    ),
            ),
            labelText: 'Write a message...'),
      ),
    );
  }
}
