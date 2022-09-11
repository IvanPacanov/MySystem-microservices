import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/repository/auth_service.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/presentation/AddNewUser/FriendsView.dart';
import 'package:flutter_client/presentation/Chat/chat_view.dart';
import 'package:flutter_client/presentation/Chat/messages/message_screen.dart';
import 'package:flutter_client/presentation/Guardian/bloc/guardian_bloc.dart';
import 'package:flutter_client/presentation/Guardian/guardian_view.dart';
import 'package:flutter_client/presentation/MainScreen/TextToSpeech/TextToSpeechView.dart';
import 'package:flutter_client/presentation/MainScreen/main_screen.dart';
import 'package:flutter_client/presentation/VideoCall.dart';
import 'package:flutter_client/presentation/VideoCalling/InComingCall.dart';
import 'package:flutter_client/presentation/VideoCalling/ReceivedUpcomingVideo.dart';
import 'package:flutter_client/services/SignalR_Services.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:flutter_client/session/chatSession/chatSession_state.dart';
import 'package:provider/provider.dart';

import '../presentation/MainPage/main_page.dart';

class SessionView extends StatelessWidget {
  SessionView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignalRProvider(),
      child: BlocProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => AuthenticatedSessionCubit(
            authServices: context.read<AuthServices>(),
            signalRProvider: context.read<SignalRProvider>(),
          ),
          child: BlocBuilder<AuthenticatedSessionCubit,
              AuthenticatedSessionState>(builder: (context, state) {
            context.read<AuthenticatedSessionCubit>().signalRProvider.onStatusGuardian =
                () => {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(100.0))),
                          title: Text(
                            'Czy wszystko jest w porządku?'
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment:
                              MainAxisAlignment.spaceAround,
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => {
                                Navigator.pop(context, 'NIE'),
                                context
                                    .read<AuthenticatedSessionCubit>()
                                    .statusGuardianNotOk()
                              },
                              child: const Text('NIE'),
                            ),
                            TextButton(
                              onPressed: () => {
                                Navigator.pop(context, 'TAK'),
                                context
                                    .read<AuthenticatedSessionCubit>()
                                    .statusGuardianOk()
                              },
                              child: const Text('TAK'),
                            ),
                          ],
                        ),
                      ),
                    };

            return _navigation(state);
          }),
        ),
      ),
    );
  }
}

Widget _navigation(AuthenticatedSessionState state) {
  return Navigator(
    pages: [
      if (state is NormalState)
        MaterialPage(
          child: MainScreen(),
        ),
      if (state is ChatViewState)
        MaterialPage(
          child: ChatView(),
        ),
      if (state is MessageViewState)
        MaterialPage(
          child: MessageScreen(
            friend: state.friend,
          ),
        ),
      if (state is InComingCalling)
        MaterialPage(
          child: InComingCall(
              callingUser: state.callingUser,
              uid: state.uid,
              offer: state.offer),
        ),
      if (state is VideoCallState)
        MaterialPage(
          child: VideoCall(
            friend: state.friend,
          ),
        ),
      if (state is ReceivedUpcomingVideoState)
        MaterialPage(
            child: ChangeNotifierProvider(
          create: (BuildContext context) {},
          child: ReceivedUpcomingVideo(
            offer: state.offer,
            uid: state.uid,
          ),
        )),
      if (state is FriendViewState)
        MaterialPage(
          child: FriendsView(),
        ),
      if (state is TextToSpeechState)
        MaterialPage(
          child: TextToSpeechView(),
        ),
      if (state is GuardianViewState)
        MaterialPage(
          child: BlocProvider(
            create: (context) => GuardianBloc(
                authenticatedSessionCubit:
                    context.read<AuthenticatedSessionCubit>()),
            child: GuardianView(user: state.user),
          ),
        ),
    ],
    onPopPage: (route, result) => route.didPop(result),
  );
}
