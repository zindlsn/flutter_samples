///Represents a message within the [Chat]
///
class MessageEntity implements Comparable<MessageEntity>  {
  String ownerId;
  String text;
  DateTime? sentTime;
  DateTime creationDate;
  bool sendFromMe = false;

  MessageEntity(
      {required this.ownerId, required this.text, required this.creationDate});

  static MessageEntity newMessage(String message) {
    return MessageEntity(
      ownerId: "",
      text: message,
      creationDate: DateTime.now(),
    );
  }

  @override
  int compareTo(other) {
    return creationDate.isAfter(other.creationDate) ? -1 : 1;
  }
}
