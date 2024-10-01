import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/GeoLocatorFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

part 'my_location_state.dart';

class MyLocationCubit extends Cubit<MyLocationState> {
  MyLocationCubit(this.locationRepo) : super(MyLocationInitial());

  final LocationRepo locationRepo;

  Future<void> getMyLocation() async {
    emit(CheckLocationLoading());
    RequestResault res = await locationRepo.getMyLocation();
    if (res is RequestSuccess) {
      emit(GetLocationSuccessed(positionEntity: res.data));
    } else if (res is RequestFailed) {
      emit(GetLocationFailed(error: GeolocatorFailureHandler(res.data)));
    }
  }
}
