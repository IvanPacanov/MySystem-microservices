import 'package:flutter_client/auth/form_submission_status.dart';
import 'package:flutter_client/models/User.dart';

class ChatState {
  final FormSubmissionStatus formStatus;
  final List<User> users;

  ChatState(
      {required this.users,
      this.formStatus = const InitialFormStatus()});

  ChatState addNewElement(User us) {
    this.users.add(us);
    return ChatState(users: this.users);
  }
}
