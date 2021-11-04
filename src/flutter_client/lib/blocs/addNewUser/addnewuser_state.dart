class AddnewuserState {
  final String userName;

  AddnewuserState({this.userName = ''});

  AddnewuserState copyWith({String? userName, String? password}) {
    return AddnewuserState(userName: userName ?? this.userName);
  }
}
