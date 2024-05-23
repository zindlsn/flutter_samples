import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:start/core/exexptions/firebase_exeption.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/firebase_options.dart';

class FirebaseDataSource {
  late FirebaseFirestore firestore;

  Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firestore = FirebaseFirestore.instance;
    firestore.settings = const Settings(persistenceEnabled: true);
  }

  Future<bool> updateTypingStatus(
      bool isTyping, String chatId, String userId) async {
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('typing')
        .doc(userId)
        .set(
      {
        'isTyping': isTyping,
        'updatedAt': DateTime.now(),
      },
    );
    return true;
  }

  Future<bool> deleteTypingDocument(String chatId, String userId) async {
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('typing')
        .doc(userId)
        .set(
      {
        'isTyping': false,
        'updatedAt': DateTime.now(),
      },
    );
    return true;
  }

  List<MessageEntity> subscribeToMessages() {
    List<MessageEntity> messages = [];
    firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages = snapshot.docs
          .map((doc) => MessageEntity.fromMap(doc.data()))
          .toList();
    });
    return messages;
  }

  Stream<List<Tuple2<bool, String?>>> subscribeToTypingStatus() {
    try {
      return FirebaseFirestore.instance
          .collection('chats')
          .doc('V5QCuwyF5ddv9GCzlCBQ')
          .collection('typing')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Tuple2(doc['isTyping'] as bool, "nope");
        }).toList();
      });
    } on Exception {
      if (kDebugMode) {
        print("Subscibe not working");
      }
    }
    return Stream.value([]);
  }

  Future<bool> sendMessage(MessageEntity newMessage) async {
    try {
      await firestore
          .collection('chats')
          .doc(newMessage.chatId)
          .collection('messages')
          .add({
        'ownerId': newMessage.ownerId,
        'chatId': newMessage.chatId,
        'text': newMessage.text,
        'sentTime': newMessage.sentTime,
        'creationDate': newMessage.creationDate,
        'sendFromMe': newMessage.sendFromMe,
      });
      return true;
    } catch (e) {
      throw CouldNotSendMessage();
    }
  }

  Future<List<MessageEntity>> loadMessagesByChatId(String chatId) async {
    try {
      CollectionReference<Map<String, dynamic>> refMessages = FirebaseFirestore
          .instance
          .collection('chats')
          .doc(chatId)
          .collection('messages');
      List<MessageEntity> messages = [];

      var documents = await refMessages.orderBy("creationDate").get();

      List<Map<String, dynamic>> allMessagesDocuments =
          documents.docs.map((doc) => doc.data()).toList();
      if (allMessagesDocuments.isNotEmpty) {
        for (Map<String, dynamic> messageDocument in allMessagesDocuments) {
          var m = MessageEntity.fromMap(messageDocument);
          messages.add(m);
        }
      }
      return messages;
    } on Exception {
      throw CoutNotLoadFirebaseExeption();
    }
  }
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2? item2;

  Tuple2(this.item1, this.item2);
}
