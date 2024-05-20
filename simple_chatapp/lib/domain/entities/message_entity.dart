import 'package:cloud_firestore/cloud_firestore.dart';

///Represents a message within the [Chat]
///
class MessageEntity implements Comparable<MessageEntity> {
  String ownerId;
  String chatId;
  String text;
  DateTime? sentTime;
  DateTime creationDate;
  bool sendFromMe = false;

  MessageEntity(
      {required this.ownerId,
      required this.chatId,
      required this.text,
      required this.creationDate,
      this.sentTime,
      required this.sendFromMe});

  static MessageEntity newMessage(String message) {
    return MessageEntity(
        ownerId: "",
        chatId: "",
        text: message,
        creationDate: DateTime.now(),
        sendFromMe: true);
  }

  factory MessageEntity.fromMap(Map<String, dynamic> map) {
    return MessageEntity(
      ownerId: map['ownerId'] ?? "",
      chatId: map['chatId'] as String,
      text: map['text'] as String,
      sentTime: (map['sentTime'] as Timestamp?)?.toDate(),
      creationDate: DateTime.now(),
      sendFromMe: map['sendFromMe'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'chatId': chatId,
      'text': text,
      'sentTime': sentTime,
      'creationDate': creationDate,
      'sendFromMe': sendFromMe,
    };
  }

  @override
  int compareTo(other) {
    return creationDate.isAfter(other.creationDate) ? -1 : 1;
  }
}
