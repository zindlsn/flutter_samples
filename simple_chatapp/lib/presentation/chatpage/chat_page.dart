import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/domain/entities/user_entity.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatBubble();
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(
      LoadChat(
        userEntity: UserEntity(name: 'Hanna', userId: '100123'),
      ),
    );
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Title(
                color: Colors.lightBlue,
                child: const Text(""),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    primary: false,
                    children: state.userEntity.chat.messages.map((e) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          color: Colors.blue,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('First chatbubble'),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Form(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Write a message...'),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
