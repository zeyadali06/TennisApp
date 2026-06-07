import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/AuthFeature/Data/RepoImplementation/AuthRepoImpl.dart';

part 'splash_view_state.dart';

class SplashViewCubit extends Cubit<SplashViewState> {
  SplashViewCubit({required this.authRepoImpl}) : super(SplashViewInitial());

  final AuthRepoImpl authRepoImpl;

  Future<void> autoLogin() async {
    emit(SplashViewLoading());

    RequestResult<dynamic, dynamic> res = await authRepoImpl.autoLogin();

    if (res is RequestSuccess) {
      return emit(SplashViewSuccess());
    } else if (res is RequestFailed) {
      return emit(SplashViewFailed());
    }
  }
}
