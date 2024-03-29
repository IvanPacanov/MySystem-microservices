import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_navigator.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/loading_view.dart';
import 'package:flutter_client/main.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:flutter_client/session/session_cubit.dart';
import 'package:flutter_client/session/session_state.dart';
import 'package:flutter_client/session/session_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SessionCubit(authServices: context.read<AuthServices>()),
      child: BlocBuilder<SessionCubit, SessionState>(
          builder: (context, state) {
        return _navi(state, context);
      }),
    );
  }
}

Widget _navi(SessionState state, BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      context.read<AuthenticatedSessionCubit>().lastState();
      return false;
    },
    child: Navigator(
      pages: [
        if (state is UnKnownSessionState)
          MaterialPage(
            child: LoadingView(),
          ),
        if (state is Unauthenticated)
          MaterialPage(
            child: AuthNavigator(),
          ),
        if (state is Authenticated)
          MaterialPage(
            child: SessionView(context),
          ),
      ],
      onPopPage: (route, result) => route.didPop(result),
    ),
  );
}
