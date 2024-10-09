part of 'search_for_loaction_cubit.dart';

@immutable
sealed class SearchForLoactionState {}

final class SearchForLoactionInitial extends SearchForLoactionState {}

final class SearchForLoactionLoading extends SearchForLoactionState {}

final class ChooseLocation extends SearchForLoactionState {
  final PositionEntity positionEntity;

  ChooseLocation(this.positionEntity);
}

final class ChooseLocationFinished extends SearchForLoactionState {}

final class SearchForLoactionSuccessed extends SearchForLoactionState {
  final List<PositionEntity> suggestions;

  SearchForLoactionSuccessed(this.suggestions);
}

final class SearchForLoactionFailed extends SearchForLoactionState {
  final WeatherAPIFailureHandler error;

  SearchForLoactionFailed(this.error);
}
