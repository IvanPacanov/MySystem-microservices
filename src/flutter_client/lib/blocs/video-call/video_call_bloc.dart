import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'video_call_event.dart';
import 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  bool isTrusted = false;

  VideoCallBloc() : super(VideoCallState());

  @override
  Stream<VideoCallState> mapEventToState(
      VideoCallEvent event) async* {
    if (event is ReceiveChanged) {
      //yield state.copyWith(userName: event.userName);
    }
  }
}
