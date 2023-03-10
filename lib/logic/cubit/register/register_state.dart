// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoding extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserCredential userCredential;
  RegisterSuccess({
    required this.userCredential,
  });
}

class RegisterAlreadyExist extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String error;
  RegisterFailed({required this.error});
}
