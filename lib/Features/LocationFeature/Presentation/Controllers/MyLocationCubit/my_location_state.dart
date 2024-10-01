part of 'my_location_cubit.dart';

@immutable
sealed class MyLocationState {}

final class MyLocationInitial extends MyLocationState {}

final class CheckLocationLoading extends MyLocationState {}

final class GetLocationFailed extends MyLocationState {
  final GeolocatorFailureHandler error;

  GetLocationFailed({required this.error});
}

final class GetLocationSuccessed extends MyLocationState {
  final PositionEntity positionEntity;

  GetLocationSuccessed({required this.positionEntity});
}
