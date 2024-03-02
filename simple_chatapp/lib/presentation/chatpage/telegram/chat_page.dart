import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/domain/entities/user_entity.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatBloc>(context).add(
      SetChatpartner(chatPartner: UserEntity(name: 'Hanna', userId: '321')),
    );
    BlocProvider.of<ChatBloc>(context).add(
      LoadChat(),
    );
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Title(
                color: Colors.lightBlue,
                child: Text(state.userEntity.name),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: state.userEntity.chat.messages.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          e.sendFromMe
                              ? Container(
                                  color: Colors.amber,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: OutBubble(message: e.text),
                                  ),
                                )
                              : Container(
                                  color: Colors.cyanAccent,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: InBubble(message: e.text),
                                  ),
                                ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: SendMessageElement(),
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

class SendMessageElement extends StatefulWidget {
  const SendMessageElement({super.key});

  @override
  State<SendMessageElement> createState() => _SendMessageElementState();
}

class _SendMessageElementState extends State<SendMessageElement> {
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: _messageController,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                MessageEntity messageEntity =
                    MessageEntity.newMessage(_messageController.text);
                BlocProvider.of<ChatBloc>(context).add(
                  SendChatMessage(messageEntity: messageEntity),
                );
                BlocProvider.of<ChatBloc>(context).add(
                  LoadChat(),
                );
              },
              child: const Icon(Icons.send),
            ),
            labelText: 'Write a message...'),
      ),
    );
  }
}

class InBubble extends StatelessWidget {
  final String message;
  const InBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          CustomPaint(painter: InBubbleTriangle(Colors.indigo.shade600)),
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width * 2 / 3,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(19),
                  bottomRight: Radius.circular(19),
                  topRight: Radius.circular(19),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OutBubble extends StatelessWidget {
  final String message;
  const OutBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width * 2 / 3,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.indigo.shade600,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(19),
                  bottomLeft: Radius.circular(19),
                  bottomRight: Radius.circular(19),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          CustomPaint(painter: Triangle(Colors.indigo.shade600)),
        ],
      ),
    );
  }
}

// Create a custom triangle
class InBubbleTriangle extends CustomPainter {
  final Color backgroundColor;
  InBubbleTriangle(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Create a custom triangle
class Triangle extends CustomPainter {
  final Color backgroundColor;
  Triangle(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
