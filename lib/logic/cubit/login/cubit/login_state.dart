part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginCheckingAuth extends LoginState {}

class LoginCheckingAuthFailed extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess({required this.user});
  final User user;
}

class LoginFailed extends LoginState {
  LoginFailed({required this.errorMsg});
  final String errorMsg;
}
