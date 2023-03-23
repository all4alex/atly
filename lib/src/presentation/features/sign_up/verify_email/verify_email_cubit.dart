import 'package:atly/src/data/services/api/user_service.dart';
import 'package:atly/src/utilities/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit({required this.userService}) : super(VerifyEmailInitial());

  final UserService userService;

  Future<void> sendVerificationEmail(
      {required UserCredential credential}) async {
    emit(VerifyEmailLoading());
    logger().d(credential.toString());
    try {
      await credential.user!.sendEmailVerification();
      emit(VerifyEmailSuccess(userCredential: credential));
    } on FirebaseAuthException catch (e) {
      emit(VerifyEmailFailed(error: e.message ?? 'Something went wrong.'));
    } catch (e) {
      emit(VerifyEmailFailed(error: e.toString()));
    }
  }

  Future<void> verifyEmailCodeFromEmail(
      {required UserCredential credential}) async {
    emit(VerifyEmailLoading());
    logger().d(credential.toString());
    try {
      await credential.user!.sendEmailVerification();
      emit(VerifyEmailSuccess(userCredential: credential));
    } on FirebaseAuthException catch (e) {
      emit(VerifyEmailFailed(error: e.message ?? 'Something went wrong.'));
    } catch (e) {
      emit(VerifyEmailFailed(error: e.toString()));
    }
  }
}
