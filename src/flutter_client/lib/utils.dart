import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_client/models/User.dart';

class Utils {
  // static StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
  //     dynamic> transformer<T>(
  //         T Function(Map<String, dynamic> json) fromJson) =>
  //     StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
  //       handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
  //         print("ELOOOO");
  //         print(data);
  //         final snaps = data.docs.map((doc) => doc.data()).toList();
  //         final users = snaps
  //             .map((json) => fromJson(json as Map<String, dynamic>))
  //             .toList();

  //         sink.add(users);
  //       },
  //     );

  static DateTime? toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static StreamTransformer<QuerySnapshot<dynamic>,
      dynamic> transformer2(
          User Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<User>> sink) {
          print("ELOOOO");
          print(data);
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps
              .map((json) => fromJson(json as Map<String, dynamic>))
              .toList();

          sink.add(users);
        },
      );
}
