import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/models/Chat.dart';

class NavCubit extends Cubit<Chat> {
  NavCubit() : super(new Chat());

  void showPostDetails(Chat post) => emit(post);

  void popToPosts() => emit(new Chat());
}
