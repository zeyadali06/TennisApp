part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class EmailSentSuccessfully extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserModel userModel;

  LoginSuccess(this.userModel);
}

final class LoginFailed extends LoginState {
  final FirebaseFailureHandler error;

  LoginFailed(this.error);
}
