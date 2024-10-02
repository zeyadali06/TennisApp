part of 'search_for_loaction_cubit.dart';

@immutable
sealed class SearchForLoactionState {}

final class SearchForLoactionInitial extends SearchForLoactionState {}

final class SearchForLoactionLoading extends SearchForLoactionState {}

final class SearchForLoactionSuccessed extends SearchForLoactionState {
  final List<String> suggestions;

  SearchForLoactionSuccessed(this.suggestions);
}

final class SearchForLoactionFailed extends SearchForLoactionState {
  final WeatherAPIFailureHandler error;

  SearchForLoactionFailed(this.error);
}
