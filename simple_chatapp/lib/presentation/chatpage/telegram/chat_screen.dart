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
    BlocProvider.of<MessagesBloc>(context).add(LoadMoreMessage());

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextField(
            controller: _controller,
            onChanged: (value) => {searchMessages(value)},
          )
        ],
      ),
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
                    child: GestureDetector(
                      onTapDown: (details) {
                        /* if (_overlayEntry == null) {
                          _overlayEntry = _createOverlay(details);
                          overlayState!.insert(_overlayEntry!);
                        } else {
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                        } */
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: ((context, index) {
                          indexClicked = index;
                          MessageEntity message = messages[index];
                          return message.sendFromMe
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7 *
                                                6,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: OutBubble(
                                                  message: message.text,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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

  void searchMessages(String query) {
    // Use a stream to listen for changes in the search query
    searchQueryStream.sink.add(query);
  }

  void clearSearchResults() {
    // Clear the search query stream
    searchQueryStream.sink.add('');
  }

  Stream<String> searchQueryStream = Stream.value('');
}

class CustomSearchDelegate extends SearchDelegate<String> {
  // Dummy list
  final List<String> searchList = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grapes",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Papaya",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Watermelon",
  ];

  // These methods are mandatory you cannot skip them.

  @override
  Widget buildLeading(BuildContext context) => const Text('leading');
  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    return const PreferredSize(
        preferredSize: Size.fromHeight(56.0), child: Text('bottom'));
  }

  @override
  Widget buildSuggestions(BuildContext context) => const Text('suggestions');
  @override
  Widget buildResults(BuildContext context) => const Text('results');
  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[];
}

abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}

class SearchQueryCleared extends SearchEvent {}

class SearchState {
  final String query;
  final List<MessageEntity> filteredMessages;

  SearchState({
    required this.query,
    required this.filteredMessages,
  });

  SearchState copyWith({
    String? query,
    List<MessageEntity>? filteredMessages,
  }) {
    return SearchState(
      query: query ?? this.query,
      filteredMessages: filteredMessages ?? this.filteredMessages,
    );
  }
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<MessageEntity> chatMessages;

  SearchBloc(this.chatMessages)
      : super(SearchState(query: '', filteredMessages: chatMessages)) {
    on<SearchQueryChanged>((event, emit) {
      final filteredMessages = chatMessages.where((message) {
        return message.text.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
      emit(state.copyWith(
          query: event.query, filteredMessages: filteredMessages));
    });

    on<SearchQueryCleared>((event, emit) {
      emit(state.copyWith(query: '', filteredMessages: chatMessages));
    });
  }

  Widget buildSearchBar() {
    TextEditingController _controller = TextEditingController();
    SearchBloc searchBloc = SearchBloc(chatMessages);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchState) {
          return Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.search, color: Colors.grey, size: 24),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      // Perform search logic
                      searchBloc.add(SearchQueryChanged(value));
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Search messages',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                if (_controller.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      // Clear search results
                      searchBloc.add(SearchQueryCleared());
                    },
                    child:
                        const Icon(Icons.clear, color: Colors.grey, size: 20),
                  ),
                const SizedBox(width: 10),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[200],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
