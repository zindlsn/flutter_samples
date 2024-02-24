///Represents a message within the [Chat]
///
class MessageEntity{
  String ownerId;
  String text;
  DateTime sentTime;

  MessageEntity({required this.ownerId, required this.text, required this.sentTime});
}