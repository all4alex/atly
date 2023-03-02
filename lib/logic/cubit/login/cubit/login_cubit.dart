import 'dart:math';

import 'package:atly/data/services/local/secure_storage_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  SecureStorage secureStorage = SecureStorage();

  Future<void> checkUserAuth() async {
    emit(LoginCheckingAuth());
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      print(user);
      if (user != null) {
        await secureStorage.saveCurrentUser(user.toString());
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
            firstName: 'Alex',
            id: user.uid, // UID from Firebase Authentication
            imageUrl: 'https://i.pravatar.cc/300',
            lastName: 'Tester',
          ),
        );
        emit(LoginSuccess(user: FirebaseAuth.instance.currentUser!));
      } else {
        emit(LoginCheckingAuthFailed());
      }
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      emit(LoginFailed(errorMsg: '${e.message}'));
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      secureStorage.saveCurrentUser(credential.user.toString());

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: 'Alex',
          id: credential.user!.uid, // UID from Firebase Authentication
          imageUrl: 'https://i.pravatar.cc/300',
          lastName: 'Tester',
        ),
      );
      emit(LoginSuccess(user: credential.user!));
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      emit(LoginFailed(errorMsg: '${e.message}'));
    }
  }
}
