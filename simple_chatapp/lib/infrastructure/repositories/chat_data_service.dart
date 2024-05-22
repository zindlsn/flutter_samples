import 'package:start/domain/entities/chat_entity.dart';

class ChatRepositoryImpl {
  List<ChatEntity> chats = [];

  ChatEntity? currentTextingChat;

  void loadChatPartners() {
    chats = [
      ChatEntity(messages: [], chatId: "V5QCuwyF5ddv9GCzlCBQ", name: "Hannah")
    ];
  }

  void setCurrentTextingChat(ChatEntity chat) {
    currentTextingChat = chat;
  }

  void addChat(ChatEntity chat) {
    chats.add(chat);
  }

  ChatEntity retreiveChatByChatId(String chatId) {
    return chats.where((chat) => chat.chatId == chatId).first;
  }
}
