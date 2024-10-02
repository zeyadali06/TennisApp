part of 'get_my_location_cubit.dart';

@immutable
sealed class GetMyLocationState {}

final class MyLocationInitial extends GetMyLocationState {}

final class CheckLocationLoading extends GetMyLocationState {}

final class GetLocationSuccessed extends GetMyLocationState {
  final PositionEntity positionEntity;

  GetLocationSuccessed(this.positionEntity);
}

final class GetLocationFailed extends GetMyLocationState {
  final GeolocatorFailureHandler error;

  GetLocationFailed(this.error);
}
