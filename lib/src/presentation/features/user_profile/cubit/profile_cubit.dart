import 'package:atly/main.dart';
import 'package:atly/src/app/atly_app.dart';
import 'package:atly/src/data/models/user_profile_model.dart';
import 'package:atly/src/data/services/remote/user_service.dart';
import 'package:atly/src/data/services/local/secure_storage_service.dart';
import 'package:atly/src/utilities/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.userService}) : super(ProfileInitial());

  final UserService userService;

  void initChatUser(String uid, String firstName, String lastName) async {
    await FirebaseChatCore.instance.createUserInFirestore(
      types.User(
        firstName: firstName,
        id: uid,
        imageUrl: '',
        lastName: lastName,
      ),
    );
  }

  void getUserProfile() async {
    emit(ProfileLoading());

    try {
      final User? user = firebaseAuth.currentUser;
      final UserProfileModel? userProfileModel =
          await userService.getUserProfile(id: user!.uid);

      logger().d(userProfileModel);
      if (userProfileModel != null) {
        initChatUser(
            user.uid, userProfileModel.firstName!, userProfileModel.lastName!);

        emit(ProfileSuccess(userProfileModel: userProfileModel));
      } else {
        emit(ProfileFailed());
      }
    } catch (e) {
      logger().e(e);
      emit(ProfileFailed());
    }
  }

  void saveUserProfile({required UserProfileModel userProfileModel}) async {
    emit(SaveProfileLoading());

    try {
      final User? user = firebaseAuth.currentUser;

      print(user);
      await userService.addUserProfile(
          userProfileModel: userProfileModel, id: user!.uid);
      emit(SaveProfileSuccess(userProfileModel: userProfileModel));
    } catch (e) {
      print(e);
      emit(SaveProfileFailed());
    }
  }

  void updateUserProfile({
    required UserProfileModel userProfileModel,
    required String userId,
  }) async {
    emit(SaveProfileLoading());

    try {
      final User? user = currentUser;
      if (user != null) {
        await userService.updateUserProfile(
            userProfileModel: userProfileModel, id: user.uid);
      } else {
        print('Not authenticated');
        emit(SaveProfileFailed());
      }

      emit(SaveProfileSuccess(userProfileModel: userProfileModel));
    } catch (e) {
      print(e);
      emit(SaveProfileFailed());
    }
  }
}
