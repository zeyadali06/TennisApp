import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/AuthFeature/Domain/RepoInterface/AuthRepo.dart';

part 'navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit(this.authRepo) : super(NavigationBarInitial());

  final AuthRepo authRepo;

  Future<void> logout() async {
    emit(NavigationBarLoading());
    final RequestResult res = await authRepo.logout();
    if (res is RequestSuccess) {
      emit(NavigationBarLogout());
    } else if (res is RequestFailed) {
      emit(NavigationBarFailed(res.data));
    }
  }
}
