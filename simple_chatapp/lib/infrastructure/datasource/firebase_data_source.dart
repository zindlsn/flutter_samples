import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/firebase_options.dart';

class FirebaseDataSource {
  late FirebaseFirestore _db;
  Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _db = FirebaseFirestore.instance;
    _db.settings = const Settings(persistenceEnabled: true);
  }

  Future<void> createMessage(MessageEntity newMessage) async {
    try {
      await _db.collection('messages').add({
        'ownerId': newMessage.ownerId,
        'chatId': newMessage.chatId,
        'text': newMessage.text,
        'sentTime': newMessage.sentTime,
        'creationDate': newMessage.creationDate,
        'sendFromMe': newMessage.sendFromMe,
      });
    } catch (e) {
      print('Error creating message: $e');
    }
  }

  Future<List<MessageEntity>> loadMessagesByChatId(String chatId) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('messages')
          .where('chatId', isEqualTo: "")
          .get();
      List<MessageEntity> messages = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        MessageEntity message = MessageEntity(
          ownerId: data['ownerId'],
          chatId: data['chatId'],
          text: data['text'],
          sentTime: data['sentTime'] ?? DateTime.now(),
          creationDate: (data['creationDate'] as Timestamp).toDate(),
          sendFromMe: data['sendFromMe'],
        );
        messages.add(message);
      }

      return messages;
    } catch (e) {
      print('Error loading messages: $e');
      return [];
    }
  }
}
