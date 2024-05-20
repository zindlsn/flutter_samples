import 'package:start/domain/entities/chat_entity.dart';

class ChatDataRepository {
  List<ChatEntity> chats = [
    ChatEntity(messages: [], chatId: "V5QCuwyF5ddv9GCzlCBQ", name: "Hannah")
  ];

  ChatEntity? currentTextingChat;

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
