enum MessageStatus { not_sent, not_view, viewed }
enum MessageType { text }

class ChatMessage {
  final String? idChat;
  final String? user;
  final String? text;
  final MessageStatus? messageStatus;
  final MessageType? messageType;
  final bool? isSender;

  ChatMessage(
      {this.idChat,
      required this.user,
      required this.text,
      required this.messageStatus,
      required this.isSender,
      required this.messageType});

  Map<String, dynamic> toJson() => {
        'user': user,
        'text': text,
        'messageStatus': messageStatus.toString(),
        'isSender': isSender,
        'messageType': messageType.toString(),
      };

  copyWith(
          {String? idChat,
          String? user,
          String? text,
          MessageStatus? messageStatus,
          MessageType? messageType,
          bool? isSender}) =>
      ChatMessage(
          idChat: idChat,
          user: user,
          text: text,
          messageStatus: messageStatus,
          isSender: isSender,
          messageType: messageType);
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
