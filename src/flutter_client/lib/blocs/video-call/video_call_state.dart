class VideoCallState {
  final String userName;

  VideoCallState({this.userName = ''});

  VideoCallState copyWith({String? userName, String? password}) {
    return VideoCallState(userName: userName ?? this.userName);
  }
}


