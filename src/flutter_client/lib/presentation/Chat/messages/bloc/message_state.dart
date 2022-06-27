part of 'message_bloc.dart';

class MessageState {
  final String message;

  MessageState({required this.message});

  MessageState copyWith({required String message}) {
    return MessageState(message: message);
  }
}
