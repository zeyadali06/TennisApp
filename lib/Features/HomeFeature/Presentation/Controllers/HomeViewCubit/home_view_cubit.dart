import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/HomeRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/CurrentWeatherEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit(this.homeRepo, this.locationManagerRepo) : super(HomeViewInitial());

  final HomeRepo homeRepo;
  final LocationManagerRepo locationManagerRepo;

  Future<void> getCurrentWeather() async {
    emit(HomeViewLoading());
    RequestResault<dynamic, dynamic> res = await homeRepo.getCurrentWeather();
    if (res is RequestSuccess) {
      return emit(HomeViewSuccess(res.data));
    } else if (res is RequestFailed) {
      return emit(HomeViewFailed(res.data));
    }
  }
}
