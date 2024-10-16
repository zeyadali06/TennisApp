import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/AIModelFailureHandler.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/GetPredictionUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/AnotherDayWeatherUseCase.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/UseCases/CurrentDayWeatherUseCase.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit(this.currentDayWeatherUseCase, this.anotherDayWeatherUseCase, this.locationManagerRepo, this.getPredictionUseCase) : super(HomeViewInitial());

  final CurrentDayWeatherUseCase currentDayWeatherUseCase;
  final AnotherDayWeatherUseCase anotherDayWeatherUseCase;
  final LocationManagerRepo locationManagerRepo;
  final GetPredictionUseCase getPredictionUseCase;

  Future<void> getCurrentWeather() async {
    emit(HomeViewLoading());
    RequestResault res = await currentDayWeatherUseCase.getCurrrentDayWeather();
    if (res is RequestSuccess) {
      return emit(HomeViewSuccess(res.data));
    } else if (res is RequestFailed) {
      return emit(HomeViewFailed(res.data));
    }
  }

  Future<void> getForecastWeather(DateTime dateTime) async {
    emit(HomeViewLoading());
    RequestResault res = await anotherDayWeatherUseCase.getAnotherDayWeather(dateTime);
    if (res is RequestSuccess) {
      return emit(HomeViewSuccess(res.data));
    } else if (res is RequestFailed) {
      return emit(HomeViewFailed(res.data));
    }
  }

  Future<void> getPrediction() async {
    emit(HomeViewLoading());
    RequestResault res = await getPredictionUseCase.getPrediction();
    if (res is RequestSuccess) {
      return emit(GetPredictionSuccess(res.data));
    } else if (res is RequestFailed) {
      return emit(GetPredictionFailed(res.data));
    }
  }
}
