import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/AuthFeature/Data/Models/UserModel.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;

  Future<void> login(LoginEntity loginEntity, String password) async {
    emit(LoginLoading());
    try {
      RequestResault<dynamic, dynamic> res = await authRepo.login(loginEntity, password);
      if (res is RequestSuccess) {
        return emit(LoginSuccess(res.data));
      } else if (res is RequestFailed) {
        return emit(LoginFailed(res.data));
      }
    } catch (e) {
      return emit(LoginFailed(FirebaseFailureHandler(e)));
    }
  }
}
