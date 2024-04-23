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
      required this.creationDate,this.sentTime, required this.sendFromMe});

  static MessageEntity newMessage(String message) {
    return MessageEntity(
      ownerId: "",
      chatId: "",
      text: message,
      creationDate: DateTime.now(),
      sendFromMe: true
    );
  }

  @override
  int compareTo(other) {
    return creationDate.isAfter(other.creationDate) ? -1 : 1;
  }
}
