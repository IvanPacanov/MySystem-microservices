import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/session/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthServices authServices;
  late User user;

  SessionCubit({required this.authServices})
      : super(UnKnownSessionState()) {
    emit(Unauthenticated());
    authServices.getUserId().then((value) async => getUser(value));
  }

  void getUser(value) async {
    print(value);
    if (value != null) {
      this.user = await authServices.getProfile(email: value);

      emit(Authenticated(
        user: this.user,
      ));
    } else {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(User credentials) {
    final user = credentials;
    emit(Authenticated(user: user));
  }

  void logout() {
    authServices.logout();
    emit(Unauthenticated());
  }
}
