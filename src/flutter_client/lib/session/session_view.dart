import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/presentation/Chat/chat_view.dart';
import 'package:flutter_client/presentation/VideoCalling/ComingVideo.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';
import 'package:flutter_client/session/chatSession/chatSession_state.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (context) =>
          ChatSessionCubit(),
      child: BlocBuilder<ChatSessionCubit, ChatSessionState>(
          builder: (context, state) {
        return _navi(state);
      }),
    );
  }
}


Widget _navi(ChatSessionState state) {
  return Navigator(
    pages: [
      if (state is NormalState)
        MaterialPage(
          child: ChatView(),
        ),
      if (state is ComingCalling)
        MaterialPage(
          child: ComingVideo(offer: state.offer, uid: state.uid),
        ),      
    ],
    onPopPage: (route, result) => route.didPop(result),
  );
}
