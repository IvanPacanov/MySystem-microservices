import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_client/components/chat/chat_state.dart';
import 'package:flutter_client/components/component_cubit.dart';
import 'package:flutter_client/components/component_repository.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/repositories/firebase_api.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  //final ComponentRepository componehtRepository;
  //final ComponentCubit componehtCubit;

  ChatBloc() : super(ChatState(users: []));

  Stream<QuerySnapshot> get todos {
    print("elooo");

    var a = FirebaseFirestore.instance
        .collection('users')
        .doc('0sqzFChjC7rL1Iq7MtBz')
        .collection('friends')
        .snapshots();
    return a;
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatDownloadFirstData) {
      print("Cos");
    }
  }
}

final blocChat = ChatBloc();
