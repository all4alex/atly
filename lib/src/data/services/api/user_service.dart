import 'package:atly/src/data/models/user_profile_model.dart';
import 'package:atly/src/utilities/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserService {
  Future<bool> addUserProfile(
      {required UserProfileModel userProfileModel, required String id});
  Future<void> updateUserProfile(
      {required UserProfileModel userProfileModel, required String id});
  Future<UserProfileModel?> getUserProfile({required String id});
}

class UserServiceImpl implements UserService {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('user_profile')
      .withConverter<UserProfileModel>(
        fromFirestore: (snapshot, _) =>
            UserProfileModel.fromMap(snapshot.data()!),
        toFirestore: (userProfile, _) => userProfile.toMap(),
      );

  @override
  Future<bool> addUserProfile(
      {required UserProfileModel userProfileModel, required String id}) {
    return collectionReference.doc(id).set(userProfileModel).then((value) {
      print("Profile added");
      return true;
    }).catchError((error) {
      print("Failed to add user: $error");
      return false;
    });
  }

  @override
  Future<UserProfileModel?> getUserProfile({required String id}) async {
    UserProfileModel? userProfileModel;
    await collectionReference.doc(id).get().then(
        (DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        userProfileModel = documentSnapshot.data() as UserProfileModel;
      } else {
        print('Document does not exist on the database');
      }
    }, onError: (e) {
      logger().e(e);
    });
    return userProfileModel;
  }

  @override
  Future<void> updateUserProfile(
      {required UserProfileModel userProfileModel, required String id}) {
    return collectionReference.doc(id).set(userProfileModel).then((value) {
      print("Profile added");
      return true;
    }).catchError((error) {
      print("Failed to add user: $error");
      return false;
    });
  }
}
