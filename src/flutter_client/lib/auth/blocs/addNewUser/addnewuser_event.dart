abstract class AddnewuserEvent {}

class UserNameChanged extends AddnewuserEvent {
  final String userName;

  UserNameChanged({required this.userName});
}

class AddNewFriend extends AddnewuserEvent {

}
