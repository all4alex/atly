part of 'verify_email_cubit.dart';

abstract class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {
  final UserCredential userCredential;
  VerifyEmailSuccess({
    required this.userCredential,
  });
}

class VerifyEmailFailed extends VerifyEmailState {
  final String error;
  VerifyEmailFailed({
    required this.error,
  });
}

class SendingEmailVerification extends VerifyEmailState {}

class SendEmailVerification extends VerifyEmailState {
  final UserCredential userCredential;
  SendEmailVerification({
    required this.userCredential,
  });
}

class SendEmailVerificationFailed extends VerifyEmailState {
  final String error;
  SendEmailVerificationFailed({
    required this.error,
  });
}
