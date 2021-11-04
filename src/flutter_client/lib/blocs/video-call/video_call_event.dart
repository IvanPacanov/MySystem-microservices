abstract class VideoCallEvent {}

class ReceiveChanged extends VideoCallEvent {
  final String userName;

  ReceiveChanged({required this.userName});
}