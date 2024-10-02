import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/UseCases/ForgetPasswordUseCase.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordUseCase) : super(ForgetPasswordInitial());

  final ForgetPasswordUseCase forgetPasswordUseCase;

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());

    RequestResault<dynamic, dynamic> res = await forgetPasswordUseCase.forgetPassword(email);

    if (res is RequestSuccess) {
      return emit(EmailSentSuccessfully());
    } else if (res is RequestFailed) {
      return emit(ForgetPasswordFailed(res.data));
    }
  }
}
