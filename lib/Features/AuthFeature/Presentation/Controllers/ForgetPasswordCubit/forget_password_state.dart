part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class EmailSentSuccessfully extends ForgetPasswordState {}

final class ForgetPasswordFailed extends ForgetPasswordState {
  final FirebaseFailureHandler error;

  ForgetPasswordFailed(this.error);
}
