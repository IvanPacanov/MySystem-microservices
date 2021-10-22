import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_navigator.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/loading_view.dart';
import 'package:flutter_client/session/session_cubit.dart';
import 'package:flutter_client/session/session_state.dart';
import 'package:flutter_client/session/session_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SessionCubit(authRepo: context.read<AuthRepository>()),
      child: BlocBuilder<SessionCubit, SessionState>(
          builder: (context, state) {
        return _navi(state);
      }),
    );
  }
}

Widget _navi(SessionState state) {
  return Navigator(
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
          child: SessionView(),
        ),
    ],
    onPopPage: (route, result) => route.didPop(result),
  );
}
