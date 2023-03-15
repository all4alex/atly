// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserProfileModel userProfileModel;
  ProfileSuccess({
    required this.userProfileModel,
  });
}

class ProfileFailed extends ProfileState {}

class SaveProfileLoading extends ProfileState {}

class SaveProfileSuccess extends ProfileState {
  final UserProfileModel userProfileModel;
  SaveProfileSuccess({
    required this.userProfileModel,
  });
}

class SaveProfileFailed extends ProfileState {}
