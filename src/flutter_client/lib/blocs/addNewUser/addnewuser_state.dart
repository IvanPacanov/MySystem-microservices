class AddNewUserState {
  final String userName;

  AddNewUserState({this.userName = ''});

  AddNewUserState copyWith({String? userName, String? password}) {
    return AddNewUserState(userName: userName ?? this.userName);
  }
}


