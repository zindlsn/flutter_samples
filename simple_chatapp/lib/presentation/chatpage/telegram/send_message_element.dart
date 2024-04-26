import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';

class SendMessageElement extends StatefulWidget {
  const SendMessageElement({super.key});

  @override
  State<SendMessageElement> createState() => _SendMessageElementState();
}

class _SendMessageElementState extends State<SendMessageElement> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: _messageController,
        onChanged: (text) {
          BlocProvider.of<MessagesBloc>(context).add(
            StartTypingEvent("me"),
          );
        },
        decoration: InputDecoration(
            fillColor: Colors.blue,
            suffixIcon: GestureDetector(
              onTap: () {
                BlocProvider.of<MessagesBloc>(context).add(
                  SendMessage(text: _messageController.text),
                );
                BlocProvider.of<MessagesBloc>(context).add(LoadMoreMessage());
              },
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
