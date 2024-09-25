import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/UseCases/ForgetPasswordUseCase.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordUseCase) : super(ForgetPasswordInitial());

  final ForgetPasswordUseCase forgetPasswordUseCase;

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    try {
      FirebaseResult<dynamic, dynamic> res = await forgetPasswordUseCase.forgetPassword(email);
      if (res is FirebaseSuccess) {
        return emit(EmailSentSuccessfully());
      } else if (res is FirebaseFailure) {
        return emit(ForgetPasswordFailed(res.data));
      }
    } catch (e) {
      return emit(ForgetPasswordFailed(FirebaseFailureHandler(e)));
    }
  }
}
