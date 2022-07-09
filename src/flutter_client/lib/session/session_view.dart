import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/repository/auth_service.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/presentation/Chat/chat_view.dart';
import 'package:flutter_client/presentation/MainScreen/main_screen.dart';
import 'package:flutter_client/presentation/VideoCalling/ComingVideo.dart';
import 'package:flutter_client/presentation/VideoCalling/InComingCall.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:flutter_client/session/chatSession/chatSession_state.dart';
import 'package:flutter_client/session/session_cubit.dart';

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
              user: context.read<SessionCubit>().user),
          child: BlocBuilder<AuthenticatedSessionCubit,
              AuthenticatedSessionState>(builder: (context, state) {
            return _navigation(state);
          }),
        ),
      ),
    );
  }
}

Widget _navigation(AuthenticatedSessionState state) {
  return Navigator(pages: [
    if (state is NormalState)
      MaterialPage(
        child: MainScreen(),
      ),
    if (state is InComingCalling)
      MaterialPage(
        child: InComingCall(callingUser: state.callingUser),
      ),
    if (state is ComingCalling)
      MaterialPage(
        child: ComingVideo(offer: state.offer, uid: state.uid),
      ),
  ], onPopPage: (route, result) => route.didPop(result));
}
