part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess({required this.credential});
  final UserCredential credential;
}

class LoginFailed extends LoginState {
  LoginFailed({required this.errorMsg});
  final String errorMsg;
}
