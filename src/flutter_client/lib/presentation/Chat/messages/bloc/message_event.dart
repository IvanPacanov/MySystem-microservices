part of 'message_bloc.dart';

abstract class MessageEvent {}

class MessageChanged extends MessageEvent {
  final String message;

  MessageChanged({required this.message});
}

class MessageSend extends MessageEvent {
  final UserFriend friend;
  final int chatId;


  MessageSend(this.friend, this.chatId);
}
