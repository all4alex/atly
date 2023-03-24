import 'dart:async';

import 'package:atly/src/utilities/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial()) {
    monitorNotificationUpdates();
  }

  StreamSubscription monitorNotificationUpdates() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      emit(NotificationCountUpdated(count: event.data()!.length));
    });
  }
}
