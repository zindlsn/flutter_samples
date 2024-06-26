import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/application/chat/bloc/chat_bloc.dart';
import 'package:start/domain/entities/chat_entity.dart';

class ChatPartnerListElement extends StatelessWidget {
  final ChatRoomEntity chatPartner;
  const ChatPartnerListElement({super.key, required this.chatPartner});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImage(chatPartner: chatPartner),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chatPartner.name),
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoaded &&
                      state.chat.chatRoomId == chatPartner.chatRoomId) {
                    return Text(state.loadedMessages.isNotEmpty
                        ? state.loadedMessages.lastOrNull!.text
                        : '');
                  }
                  return const Text("");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final ChatRoomEntity chatPartner;
  const ProfileImage({super.key, required this.chatPartner});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: chatPartner.chatRoomProfileImage != null
          ? Image.memory(chatPartner.chatRoomProfileImage!)
          : const Placeholder(),
    );
  }
}
