import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/blocs/addNewUser/addnewuser_event.dart';
import 'package:flutter_client/auth/blocs/addNewUser/addnewuser_state.dart';
import 'package:flutter_client/components/component_repository.dart';

class AddNewUserBloc extends Bloc<AddnewuserEvent, AddnewuserState> {
  bool isTrusted = false;
  final ComponentRepository componetRepository;

  AddNewUserBloc({required this.componetRepository})
      : super(AddnewuserState());

  @override
  Stream<AddnewuserState> mapEventToState(
      AddnewuserEvent event) async* {
    if (event is UserNameChanged) {
      yield state.copyWith(userName: event.userName);
    } else if (event is AddNewFriend) {
       componetRepository.addNewFriend(event.userUid ,state.userName);
    }
  }
}
