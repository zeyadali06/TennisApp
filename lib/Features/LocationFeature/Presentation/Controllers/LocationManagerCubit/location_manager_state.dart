part of 'location_manager_cubit.dart';

@immutable
sealed class LocationManagerState {}

final class LocationManagerInitial extends LocationManagerState {}

final class LocationManagerLoading extends LocationManagerState {}

final class LocationManagerSuccessed extends LocationManagerState {}

final class LocationManagerFailed extends LocationManagerState {
  final FirebaseFailureHandler error;

  LocationManagerFailed(this.error);
}
