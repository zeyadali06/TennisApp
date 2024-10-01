import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/GeoLocatorFailureHandler.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

part 'my_location_state.dart';

class MyLocationCubit extends Cubit<MyLocationState> {
  MyLocationCubit(this.locationRepo) : super(MyLocationInitial());

  final LocationRepo locationRepo;
  late bool permEnabled;

  Future<void> getMyLocation() async {
    emit(CheckLocationLoading());
    RequestResault res = await locationRepo.getMyLocation();
    if (res is RequestSuccess) {
      emit(GetLocationSuccessed(positionEntity: res.data));
    } else if (res is RequestFailed) {
      emit(LocationFailed(error: GeolocatorFailureHandler(res.data)));
    }
  }

  Future<void> checkLocationStatusAsStream(BuildContext context) async {
    emit(CheckLocationLoading());
    permEnabled = await locationRepo.checkLocationStatusAsStream(context);
    if (permEnabled) {
      emit(LocationEnabled());
    } else {
      emit(LocationFailed(error: GeolocatorFailureHandler(1)));
    }
  }

  Future<bool> checkLocationStatus() async {
    emit(CheckLocationLoading());
    permEnabled = await locationRepo.checkLocationStatus();
    if (permEnabled) {
      emit(LocationEnabled());
    } else {
      emit(LocationFailed(error: GeolocatorFailureHandler(1)));
    }
    return permEnabled;
  }

  Future<void> closeStatusStream(BuildContext context) async {
    await locationRepo.checkLocationStatusAsStreamDispose();
  }

  Future<void> openLocationSettings() async {
    emit(CheckLocationLoading());
    permEnabled = await locationRepo.checkLocationStatus();
    if (permEnabled) {
      emit(LocationEnabled());
    } else {
      if (await locationRepo.openLocationSettings()) {
        emit(LocationEnabled());
      } else {
        emit(LocationFailed(error: GeolocatorFailureHandler(1)));
      }
    }
  }
}
