import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.grey.withOpacity(0.75),
          duration: Duration(seconds: 1),
          padding: EdgeInsets.all(10),
        ),
      );
  }

  static DateTime toDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  static DateTime fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }

  static StreamTransformer transformer<T>(
      T Function(Map<String, dynamic> json) fromJson) {
    return StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
      handleData: (data, sink) {
        final snaps = data.docs.map((doc) => doc.data()).toList();
        final objects = snaps.map((json) => fromJson(json)).toList();

        sink.add(objects);
      },
    );
  }
}
