import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Core/Failure/FirebaseFailure.dart';
import 'package:weather_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:weather_app/Features/AuthFeature/Data/Models/UserModel.dart';
import 'package:weather_app/Features/AuthFeature/Domain/Entities/LoginEntity.dart';
import 'package:weather_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  AuthRepo authRepo;

  Future<void> login(LoginEntity loginEntity, String password) async {
    emit(LoginLoading());
    try {
      FirebaseResult<dynamic, dynamic> res = await authRepo.login(loginEntity, password);
      if (res is FirebaseSuccess) {
        emit(LoginSuccess(res.data));
      } else if (res is FirebaseFailure) {
        emit(LoginFailed(FirebaseFailureHandler(res.data)));
      }
    } catch (e) {
      emit(LoginFailed(FirebaseFailureHandler(e)));
    }
  }
}
