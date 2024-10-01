part of 'my_location_cubit.dart';

@immutable
sealed class MyLocationState {}

final class MyLocationInitial extends MyLocationState {}

final class CheckLocationLoading extends MyLocationState {}

final class LocationEnabled extends MyLocationState {}

final class LocationFailed extends MyLocationState {
  final GeolocatorFailureHandler error;

  LocationFailed({required this.error});
}

final class GetLocationSuccessed extends MyLocationState {
  final PositionEntity positionEntity;

  GetLocationSuccessed({required this.positionEntity});
}
