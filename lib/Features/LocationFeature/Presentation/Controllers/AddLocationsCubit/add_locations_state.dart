part of 'add_locations_cubit.dart';

@immutable
sealed class AddLocationsState {}

final class AddLocationsInitial extends AddLocationsState {}

final class AddLocationsLoading extends AddLocationsState {}

final class AddLocationsSuccessed extends AddLocationsState {}

final class AddLocationsFailed extends AddLocationsState {
  final FirebaseFailureHandler error;

  AddLocationsFailed(this.error);
}
