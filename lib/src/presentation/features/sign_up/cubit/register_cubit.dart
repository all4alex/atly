import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoding());
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.signOut;
      emit(RegisterSuccess(userCredential: credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailed(error: 'Weak Password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailed(error: 'Email already in use'));
      }
      emit(RegisterFailed(error: e.message ?? 'Something went wrong.'));
    } catch (e) {
      emit(RegisterFailed(error: e.toString()));
    }
  }
}
