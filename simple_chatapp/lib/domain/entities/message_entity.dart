import 'package:meta/meta.dart';

///Represents a message within the [Chat]
///
class MessageEntity {
  String ownerId;
  String text;
  DateTime sentTime;
  bool sendFromMe = false;

  MessageEntity(
      {required this.ownerId, required this.text, required this.sentTime});

  static MessageEntity newMessage(String message) {
    return MessageEntity(
      ownerId: "",
      text: message,
      sentTime: DateTime.now(),
    );
  }
}
