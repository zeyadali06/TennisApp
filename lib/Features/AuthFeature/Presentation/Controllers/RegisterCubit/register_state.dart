part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final UserModel userModel;

  RegisterSuccess(this.userModel);
}

final class RegisterFailed extends RegisterState {
  final FirebaseFailureHandler error;

  RegisterFailed(this.error);
}
