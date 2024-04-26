import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  OverlayState? overlayState;
  OverlayEntry? _overlayEntry;
  int indexClicked = 0;

  @override
  void initState() {
    overlayState = Overlay.of(context);
    super.initState();
  }

  OverlayEntry _createOverlay(TapDownDetails details) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    Offset position = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        top: size.height / 2,
        left: size.width / 4,
        width: size.width / 2,
        child: Material(
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.refresh),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.access_alarm),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: AnimatedEmoji(
                        AnimatedEmojis.halo,
                        animate: true,
                        repeat: false,
                        size: 24,
                      ),
                    ),
                    const Icon(Icons.search),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MessagesBloc>(context).add(MessagesInitial());
    BlocProvider.of<MessagesBloc>(context).add(LoadMoreMessage());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<MessagesBloc, MessagesState>(
            builder: (context, state) {
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Text('Test');
                      },
                    ),
                    Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: !state.isTyping
                            ? const Text('Is typing')
                            : Container(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Align(
              alignment: Alignment.bottomLeft, child: SendMessageElement()),
        ],
      ),
    );
  }

  void _scrollToBottom(BuildContext context) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
