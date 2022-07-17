abstract class AddNewUserEvent {}

class UserNameChanged extends AddNewUserEvent {
  final String userName;

  UserNameChanged({required this.userName});
}

class AddNewFriend extends AddNewUserEvent {
  final String userUid;
  AddNewFriend({required this.userUid});
}



class AddNewFriendSubmitted extends AddNewUserEvent {}
