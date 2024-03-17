import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/application/messages/bloc/messages_bloc.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/presentation/chatpage/telegram/send_message_element.dart';
import 'package:start/presentation/chatpage/telegram/widgets/message_layout.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom(context);
                  });
                  List<MessageEntity> messages =
                      BlocProvider.of<MessagesBloc>(context).messages;
                  return RefreshIndicator(
                    onRefresh: _pullRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
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
                                      width: MediaQuery.of(context).size.width /
                                          7 *
                                          6,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: OutBubble(
                                              message: message.text,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 3 * 2,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: InBubble(
                                    message: message.text,
                                  ),
                                ),
                              );
                      }),
                    ),
                  );
                } else if (state is FailureMessageLoaded) {
                  return const Text('No message loaded');
                }
                return const SizedBox(
                    width: 25, height: 25, child: CircularProgressIndicator());
              },
            ),
          ),
          const Align(
              alignment: Alignment.bottomLeft, child: SendMessageElement()),
        ],
      ),
    );
  }

  Future<void> _pullRefresh() async {
    BlocProvider.of<MessagesBloc>(context).add(LoadMoreMessage());
  }

  void _scrollToBottom(BuildContext context) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
