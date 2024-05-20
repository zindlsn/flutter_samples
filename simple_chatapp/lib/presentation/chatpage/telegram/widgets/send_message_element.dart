import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/messages/bloc/messages_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/application/typing/bloc/typing_bloc.dart';
import 'package:start/core/exexptions/string_extension.dart';
import 'package:start/main.dart';

class SendMessageElement extends StatefulWidget {
  final String chatId;
  const SendMessageElement({super.key, required this.chatId});

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
        BlocProvider.of<TypingBloc>(context)
            .add(StopTypingEvent(userId: me.userId));
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
              StartTypingEvent(userId: me.userId),
            );
          });
        },
        decoration: InputDecoration(
            fillColor: Colors.blue,
            suffixIcon: GestureDetector(
              onTap: _messageController.text.isNotEmpty
                  ? () {
                      setState(() {
                        BlocProvider.of<MessagesBloc>(context).add(
                          SendMessage(text: _messageController.text),
                        );
                        BlocProvider.of<ChatBloc>(context).add(
                          LoadChat(chatId: widget.chatId),
                        );
                        _messageController.text = StringExtension.empty;
                      });
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
