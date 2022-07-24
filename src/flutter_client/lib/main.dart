import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:torch_controller/torch_controller.dart';

import 'auth/repository/auth_service.dart';
import 'auth/services/auth_services.dart';

Future main() async {
  TorchController().initialize();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]);
    return MultiBlocProvider(
      providers: _providersBlocList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
      ),
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
    BlocProvider<AddNewUserBloc>(
      create: (BuildContext context) => AddNewUserBloc(
        authenticatedSessionCubit:
            context.read<AuthenticatedSessionCubit>(),
        authRepository: context.read<AuthServices>(),
      ),
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
  ];
}
