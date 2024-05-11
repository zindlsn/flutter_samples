import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:start/domain/entities/message_entity.dart';
import 'package:start/firebase_options.dart';

class FirebaseDataSource {
  late FirebaseFirestore firestore;
  late var auth;
  Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firestore = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;
    firestore.settings = const Settings(persistenceEnabled: true);
  }

  Future<void> updateTypingStatus(bool isTyping, String userId) async {
    await firestore
        .collection('typing')
        .doc(userId)
        .set({'isTyping': isTyping, 'userId': userId});
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

  Tuple2<bool, String?>? subscribeToTypingStatus() {
    Tuple2<bool, String?>? typingStatus;
    try {
      firestore.collection('typing').snapshots().listen((snapshot) {
        typingStatus = snapshot.docs.map((doc) {
          final data = doc.data();
          return Tuple2(data['isTyping'] as bool, data['userId'] as String);
        }).first;
      });
    } on Exception catch (ex) {
      print(ex);
    }

    return typingStatus;
  }

  Future<void> sendMessage(MessageEntity newMessage) async {
    try {
      await firestore.collection('messages').add({
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
      QuerySnapshot querySnapshot = await firestore
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

class Tuple2<T1, T2> {
  final T1 item1;
  final T2? item2;

  Tuple2(this.item1, this.item2);
}
