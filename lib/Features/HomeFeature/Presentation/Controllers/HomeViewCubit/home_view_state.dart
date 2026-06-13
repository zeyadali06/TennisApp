part of 'home_view_cubit.dart';

@immutable
sealed class HomeViewState {}

final class HomeViewInitial extends HomeViewState {}

final class HomeViewLoading extends HomeViewState {}

final class HomeViewSuccess extends HomeViewState {
  final WeatherEntity weatherEntity;

  HomeViewSuccess(this.weatherEntity);
}

final class HomeViewFailed extends HomeViewState {
  final WeatherAPIFailureHandler error;

  HomeViewFailed(this.error);
}

final class GetPredictionSuccess extends HomeViewState {
  final bool result;

  GetPredictionSuccess(this.result);
}

final class GetPredictionFailed extends HomeViewState {
  final AIModelFailureHandler error;

  GetPredictionFailed(this.error);
}
