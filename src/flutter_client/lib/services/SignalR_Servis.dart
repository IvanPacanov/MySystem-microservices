import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/environments/environments.dart';
import 'package:flutter_client/models/MessageSignalR.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRProvider extends Bloc {
  final arr = [];
  static late Timer timer;
  static HubConnection connection = HubConnectionBuilder()
      .withUrl(
          API_SOCIAL_SIGNALR,
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();

  late Function(bool update) onMessagesUpdateCallback;
  late Function(MessageSignalR message) onReceivedMessageCallback;

  late Function(bool sended) onSendOwnMessageCallback;

  late Function(List<dynamic>? update) onFriendsUpdateCallback;
  late Function(dynamic update) onFriendUpdateCallback;

  late Function(dynamic update) incomingCalling;

  late Function(dynamic update, dynamic update2) onComingCalling;

  SignalRProvider() : super(SignalRProvider);

  Future initSignalR(User user) async {
    if (connection.state == HubConnectionState.disconnected) {
      await connection.start();
    }

    connection.on('SendMessage', (message) async {
      onReceivedMessageCallback(MessageSignalR.fromJson(message?[0]));
    });

    connection.on('PickUpPhone', (message) async {
      print("OK ODEBRAŁEM CALLING");
      onComingCalling(message![0], message[1]);
    });

// poniżej odpowiednik!

    connection.on("IncomingCall", (message) async {
      incomingCalling(message?[0]);
    });

    connection.on('WelcomeOnServer', (message) async {
      print(message);
    });

    connection.on('UpdateUserList', (message) async {
      print("Zaktualizowano listę użytkowników");
      onFriendsUpdateCallback(message);
    });

    connection.on('UpdateUserFriend', (message) async {
      print("Zaktualizowano listę użytkowników");
      onFriendUpdateCallback(message?[0]);
    });

    connection.on('AnotherUserDisconected', (message) async {
      print(message);
    });

    // connection.on('SendSignal', (message) async {
    //   print("OK ODEBRAŁEM CALLING");
    //   //chatSessionCubit.comingCalling(message![0], message[1]);
    //   onComingCalling(message![0], message[1]);
    // });

    // connection.on('CandidateToConnect', (message) async {
    //   print("ODEBRAŁEM KANDYDATA");
    //   arr.add("das");
    // });

    connection.on('UserDisconected', (message) async {
      print(message);
    });

    connection.on("CallAccepted", (message) async {
      print(message);
    });

    connection.on('VideoConnecting', (message) async {
      print(message);
    });

    connection.on('CallEnded', (message) async {
      print(message);
    });

    connection.on('Errors', (message) async {
      print(message);
    });

    connection.on('SendMessageToUser', (message) async {
      print(message);
      // if (onMessagesUpdateCallback != null) {
      //   onMessagesUpdateCallback(true);
      // }
    });

    connection.on("ReceiveConnectedMessage", (message) async {
      print("Connecting...}");
      await connection.invoke('Init', args: [
        'notifApp',
        'mojarab',
        connection.connectionId,
        'notification_app'
      ]);
      print("connected SignalRProvider");
    });

    connection.on("ReceiveDisconnectedMessage", (message) async {
      print("SignalR disconnected");
      await connection.start();
    });
    var a = user.friends.map((e) => e.email).toList();
    await connection.invoke("Join", args: [user.email, a]);

    timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      if (connection.state == HubConnectionState.connected) {
        await connection.invoke('StayLiveMessage',
            args: [user.email, "I'm live"]);
        print("I am Alive!");
      } else {
        await connection.start();
      }
    });
  }

  sendMeMessage() async {
    await connection.invoke('SendMEssage', args: ['Mordeczko']);
  }

  static callToUser(String offer, String user) async {
    connection.invoke('CallUser', args: [offer, user]);
  }

  sendCandidate(List<dynamic> offer, String uid) async {
    await connection
        .invoke('SendCandidate', args: [offer[0], offer[1], uid]);
  }

  sendMessage(
      MessageSignalR message, String connectionId, int chatId) async {
    onSendOwnMessageCallback(true);
    await connection
        .invoke('SendMessage', args: [message, connectionId, chatId]);
  }

  callingToUser(String user) async {
    connection.invoke('CallingToUser', args: [user]);
  }

  stopCallingToUser(String user) async {
    connection.invoke('StopCallingToUser', args: [user]);
  }
}
