part of 'get_my_location_cubit.dart';

@immutable
sealed class GetMyLocationState {}

final class MyLocationInitial extends GetMyLocationState {}

final class CheckLocationLoading extends GetMyLocationState {}

final class GetLocationFailed extends GetMyLocationState {
  final GeolocatorFailureHandler error;

  GetLocationFailed({required this.error});
}

final class GetLocationSuccessed extends GetMyLocationState {
  final PositionEntity positionEntity;

  GetLocationSuccessed({required this.positionEntity});
}
