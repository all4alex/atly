import 'package:atly/data/models/user_profile_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void saveUserProfile({required UserProfileModel userProfileModel}) async {
    emit(ProfileLoading());

    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(
          '${userProfileModel.firstName} ${userProfileModel.lastName} ');
      emit(ProfileSuccess());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      emit(ProfileFailed());
    }
  }
}
