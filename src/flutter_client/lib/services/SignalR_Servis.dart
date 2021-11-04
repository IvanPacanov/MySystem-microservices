import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';
import 'package:signalr_core/signalr_core.dart';

final serverUrl = "https://192.168.1.106:5000/ConnectionHub";

class SignalRProvider extends Bloc {
  final ChatSessionCubit chatSessionCubit;
  final arr = [];
  static HubConnection connection = HubConnectionBuilder()
      .withUrl(
          serverUrl,
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();

  late Function(bool update) onMessagesUpdateCallback;

  SignalRProvider({required this.chatSessionCubit})
      : super(SignalRProvider);

  Future initSignalR(UserCredential user) async {
    await connection.start();

    connection.on('WelcomeOnServer', (message) async {
      print(message);
    });

    connection.on('UpdateUserList', (message) async {
      print("Zaktualizowano listę użytkowników");
      print(message);
    });

    connection.on('AnotherUserDisconected', (message) async {
      print(message);
    });

    connection.on('PickUpPhone', (message) async {
      print("OK ODEBRAŁEM CALLING");
      chatSessionCubit.comingCalling(message![0], message[1]);
    });

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

    connection.on("IncomingCall", (message) async {
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
      if (onMessagesUpdateCallback != null) {
        onMessagesUpdateCallback(true);
      }
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

    await connection.invoke("Join", args: [user.user!.uid]);

    Timer timer =
        Timer.periodic(Duration(seconds: 10), (timer) async {
      if (connection.state == HubConnectionState.connected) {
        await connection.invoke('StayLiveMessage',
            args: ['mojarab app', 'i am alive']);
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
    await connection.invoke('CallToUser', args: [offer, user]);
  }

  sendCandidate(List<dynamic> offer, String uid) async {
    await connection
        .invoke('SendCandidate', args: [offer[0], offer[1], uid]);
  }
}
