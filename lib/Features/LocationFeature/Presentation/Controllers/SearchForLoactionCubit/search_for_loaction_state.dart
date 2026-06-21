part of 'search_for_loaction_cubit.dart';

@immutable
sealed class SearchForLocationState {}

final class SearchForLocationInitial extends SearchForLocationState {}

final class SearchForLocationLoading extends SearchForLocationState {}

final class ChooseLocation extends SearchForLocationState {
  final PositionEntity positionEntity;

  ChooseLocation(this.positionEntity);
}

final class ChooseLocationFinished extends SearchForLocationState {}

final class SearchForLocationSuccessed extends SearchForLocationState {
  final List<PositionEntity> suggestions;

  SearchForLocationSuccessed(this.suggestions);
}

final class SearchForLocationFailed extends SearchForLocationState {
  final WeatherAPIFailureHandler error;

  SearchForLocationFailed(this.error);
}
