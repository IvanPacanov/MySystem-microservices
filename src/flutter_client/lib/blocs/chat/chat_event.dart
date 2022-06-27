part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatDownloadFirstData extends ChatEvent {
  final List<User> users;

  ChatDownloadFirstData({required this.users});
}

class MessageIsComming extends ChatEvent {
  
}
