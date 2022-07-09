import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/app_navigator.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/blocs/addNewUser/addnewuser_bloc.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/blocs/video-call/video_call_bloc.dart';
import 'package:flutter_client/models/ChatMessage.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/presentation/Chat/messages/bloc/message_bloc.dart';
import 'package:flutter_client/repositories/component_repository.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:flutter_client/session/session_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/repository/auth_service.dart';
import 'auth/services/auth_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FireBaseApi.addRandomUsers(Users.initUsers);
  await Permission.camera.request();
  await Permission.microphone.request();
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _providersBlocList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xff6a515e),
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: Color(0xff6a515e)),
        ),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => AuthServices(),
            ),
          ],
          child: AppNavigator(),
        ),
      ),
    );
  }
}

List<BlocProvider> _providersBlocList() {
  return [
    BlocProvider(
      create: (context) => AuthenticatedSessionCubit(
        authServices: context.read<AuthServices>(),
          signalRProvider: context.read<SignalRProvider>(),
          user: context.read<SessionCubit>().user),
    ),
    BlocProvider(
      create: (context) => VideoCallBloc(),
    ),
    BlocProvider(
      create: (context) => SignalRProvider(),
    ),    
     BlocProvider(
      create: (context) => AuthRepository(),
    ),    
    BlocProvider(
      create: (context) =>
          SessionCubit(authServices: context.read<AuthServices>()),
    ),
    BlocProvider(
      create: (context) =>
          AuthCubit(sessionCubit: context.read<SessionCubit>()),
    ),
    BlocProvider<ChatBloc>(
      create: (BuildContext context) => ChatBloc(
          authRepository: context.read<AuthServices>(),
          chatSessionCubit:
              context.read<AuthenticatedSessionCubit>()),
    ),
    BlocProvider<MessageBloc>(
      create: (BuildContext context) => MessageBloc(
          signalR: context.read<SignalRProvider>(),
          authRepository: context.read<AuthServices>()),
    ),
    // BlocProvider<AddNewUserBloc>(
    //     create: (BuildContext context) => AddNewUserBloc(
    //         componetRepository: context.read<ComponentRepository>()))
  ];
}

// class Users {
//   static get initUsers => <User>[
//         User(
//           name: 'Barack Obama',
//           urlAvatar:
//               'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/480px-President_Barack_Obama.jpg',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: new DateTime.now()
//                         .add(new Duration(minutes: -20))
//                         .toString()),
//                 ChatMessage(
//                     text: "No witam witam, co tam u Ciebie słychać?",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: false,
//                     date: new DateTime.now()
//                         .add(new Duration(minutes: -10))
//                         .toString()),
//                 ChatMessage(
//                     text:
//                         "Eee nudy robię magisterkę i piję piwko, a tam?",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Napoleon Bonaparte',
//           urlAvatar:
//               'https://upload.wikimedia.org/wikipedia/commons/9/9b/Andrea_Appiani_Napoleon_K%C3%B6nig_von_Rom.jpg',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Jessica Brooke',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Catherine from Anhalt-Zerbst',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1496203695688-3b8985780d6a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=641&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Caren Black',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1486074051793-e41332bf18fc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Tim White',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1519058082700-08a0b56da9b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Tom Springfield',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1586083702768-190ae093d34d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=695&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Sarah Field',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1492106087820-71f1a00d2b11?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Johanna Jackson',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1485178575877-1a13bf489dfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=991&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'James Schmidt',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1533227268428-f9ed0900fb3b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=879&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString().toString()),
//               ],
//             ),
//           ],
//         ),
//         User(
//           name: 'Anton Wagner',
//           urlAvatar:
//               'https://images.unsplash.com/photo-1566492031773-4f4e44671857?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//           friends: [
//             Friends(
//               idUser: '2BxUoCAJYgvipGAHJLUI',
//               name: 'James Schmidt',
//               lastMessageTime: DateTime.now().toString().toString(),
//               urlAvatar:
//                   'https://images.unsplash.com/photo-1450297350677-623de575f31c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
//               chatMessage: [
//                 ChatMessage(
//                     text: "Siemka",
//                     user: '2BxUoCAJYgvipGAHJLUI',
//                     messageStatus: MessageStatus.not_sent,
//                     messageType: MessageType.text,
//                     isSender: true,
//                     date: DateTime.now().toString().toString()),
//               ],
//             ),
//           ],
//         ),
//       ];
// }
