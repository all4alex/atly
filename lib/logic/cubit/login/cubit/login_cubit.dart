import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(LoginSuccess(credential: credential));
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      emit(LoginFailed(errorMsg: '${e.message}'));
    }
  }
}
