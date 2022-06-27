import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/models/Message.dart';
import 'package:flutter_client/models/MessageSignalR.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/repositories/user_repository.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final SignalRProvider signalR;
  final AuthRepository authRepository;

  MessageBloc({required this.signalR, required this.authRepository})
      : super(MessageState(message: ''));

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is MessageChanged) {
      print("WIADOMOŚĆ                " + event.message);
      yield state.copyWith(message: event.message);
    }

    if (event is MessageSend) {
      MessageSignalR message = new MessageSignalR(
          userId: authRepository.userNew.id!,
          text: state.message,
          read: false,
          send: DateTime.now().toString());

      signalR.sendMessage(
          message, event.friend.connectionId, event.chatId);

      _addSendedMessage(message, event.friend.id!);
    }
  }

  _addSendedMessage(MessageSignalR data, int friendId) {
    var user = authRepository.userNew.friends
        .where((z) => z.id == friendId)
        .first;

    int index = authRepository.userNew.friends.indexOf(user);

    Message message = new Message(
        userId: data.userId,
        text: data.text,
        read: data.read,
        send: data.send);

    authRepository.userNew.friends[index].chats![0].messages!
        .add(message);
  }
}
