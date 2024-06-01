import 'package:start/domain/entities/chat_entity.dart';
import 'package:start/main.dart';

class ChatRepositoryImpl {
  List<ChatRoomEntity> chats = [];

  ChatRoomEntity? currentTextingChat;

  void loadChatPartners() {
    chats = [
      ChatRoomEntity(
          messages: [], chatRoomId: "V5QCuwyF5ddv9GCzlCBQ", name: "Hannah")
        ..participants.add(me)
        ..me = me
    ];
  }

  void setCurrentTextingChat(ChatRoomEntity chat) {
    currentTextingChat = chat;
  }

  void addChat(ChatRoomEntity chat) {
    chats.add(chat);
  }

  ChatRoomEntity retreiveChatByChatId(String chatId) {
    return chats.where((chat) => chat.chatRoomId == chatId).first;
  }
}
