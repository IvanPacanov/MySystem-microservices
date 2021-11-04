enum MessageStatus { not_sent, not_view, viewed }
enum MessageType { text }

class ChatMessage {
  final String? idChat;
  final String? user;
  final String? text;
  final MessageStatus? messageStatus;
  final MessageType? messageType;
  final bool? isSender;
  final String? date;

  ChatMessage(
      {this.idChat,
      required this.user,
      required this.text,
      required this.messageStatus,
      required this.isSender,
      required this.messageType,
      required this.date});

  Map<String, dynamic> toJson() => {
        'user': user,
        'text': text,
        'messageStatus': messageStatus.toString(),
        'isSender': isSender,
        'date': date,
        'messageType': messageType.toString(),
      };

  copyWith(
          {String? idChat,
          String? user,
          String? text,
          MessageStatus? messageStatus,
          MessageType? messageType,
          bool? isSender,
          String? date}) =>
      ChatMessage(
          user: user,
          text: text,
          messageStatus: messageStatus,
          isSender: isSender,
          messageType: messageType,
          date: date);

  static ChatMessage fromJson(Map<String, dynamic> data) =>
      ChatMessage(
          user: data['user'],
          text: data['text'],
          messageStatus: MessageStatus.viewed,
          isSender: data['isSender'],
          date: data['date'],
          messageType: MessageType.text);
}

List mockChatMesage = [
  // ChatMessage(
  //     text: "Siemka",
  //     messageStatus: MessageStatus.not_sent,
  //     messageType: MessageType.text,
  //     isSender: true),
  // ChatMessage(
  //     text: "Cześć",
  //     messageStatus: MessageStatus.not_sent,
  //     messageType: MessageType.text,
  //     isSender: false),
  // ChatMessage(
  //     text: "Co tam słychać?",
  //     messageStatus: MessageStatus.not_sent,
  //     messageType: MessageType.text,
  //     isSender: true),
  // ChatMessage(
  //     text: "Wszystko w porządku",
  //     messageStatus: MessageStatus.not_sent,
  //     messageType: MessageType.text,
  //     isSender: false),
];
