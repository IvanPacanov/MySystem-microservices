import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/blocs/addNewUser/addnewuser_event.dart';
import 'package:flutter_client/auth/blocs/addNewUser/addnewuser_state.dart';

class AddnewuserBloc extends Bloc<AddnewuserEvent, AddnewuserState> {
  bool isTrusted = false;

  AddnewuserBloc() : super(AddnewuserState());

  @override
  Stream<AddnewuserState> mapEventToState(
      AddnewuserEvent event) async* {
    if (event is UserNameChanged) {
      yield state.copyWith(userName: event.userName);
    } else if (event is AddNewFriend) {}
  }
}
