import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';
import 'package:start/domain/entities/message_entity.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoaded) {
                  List<MessageEntity> messages =
                      BlocProvider.of<MessagesBloc>(context).messages;
                  return ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: ((context, index) {
                      MessageEntity message = messages[index];
                      return message.sendFromMe
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width /
                                            6 *
                                            5,
                                    color: const Color.fromARGB(
                                        255, 124, 111, 111),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(index.toString()),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      3 *
                                      2,
                                  color:
                                      const Color.fromARGB(255, 1, 8, 99),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(message.text),
                                  ),
                                ),
                              ],
                            );
                    }),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
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
