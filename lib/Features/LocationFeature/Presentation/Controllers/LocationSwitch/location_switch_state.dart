part of 'location_switch_cubit.dart';

@immutable
sealed class LocationSwitchState {}

final class LocationSwitchInitial extends LocationSwitchState {}

final class UpdateSwitchStatus extends LocationSwitchState {
  final bool status;

  UpdateSwitchStatus({required this.status});
}

final class StatusUpdated extends LocationSwitchState {}
