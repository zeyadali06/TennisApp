import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_switch_state.dart';

class LocationSwitchCubit extends Cubit<LocationSwitchState> {
  LocationSwitchCubit() : super(LocationSwitchInitial());

  void locationStatus(bool status) async {
    emit(UpdateSwitchStatus(status: status));
    emit(StatusUpdated());
  }
}
