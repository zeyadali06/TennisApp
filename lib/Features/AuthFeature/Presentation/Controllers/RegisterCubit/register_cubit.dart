import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Core/Failure/FirebaseFailure.dart';
import 'package:weather_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:weather_app/Features/AuthFeature/Data/Models/UserModel.dart';
import 'package:weather_app/Features/AuthFeature/Domain/Entities/RegisterEntity.dart';
import 'package:weather_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());

  AuthRepo authRepo;

  Future<void> register(RegisterEntity registerEntity, String password) async {
    emit(RegisterLoading());
    try {
      FirebaseResult<dynamic, dynamic> res = await authRepo.register(registerEntity, password);
      if (res is FirebaseSuccess) {
        return emit(RegisterSuccess(res.data));
      } else if (res is FirebaseFailure) {
        return emit(RegisterFailed(res.data));
      }
    } catch (e) {
      return emit(RegisterFailed(FirebaseFailureHandler(e)));
    }
  }
}
