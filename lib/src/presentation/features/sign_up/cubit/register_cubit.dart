import 'dart:math';

import 'package:atly/src/data/models/user_profile_model.dart';
import 'package:atly/src/data/services/api/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.userService}) : super(RegisterInitial());
  final UserService userService;

  Future<void> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(RegisterLoding());
    try {
      print(email);
      print(password);

      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userService.addUserProfile(
          userProfileModel: UserProfileModel(), id: credential.user!.uid);
      emit(RegisterSuccess(userCredential: credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailed(error: 'Weak Password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailed(error: 'Email already in use'));
      }
      print(e.message);
      print(e.code);

      emit(RegisterFailed(error: e.message ?? 'Something went wrong.'));
    } catch (e) {
      emit(RegisterFailed(error: e.toString()));
    }
  }
}
