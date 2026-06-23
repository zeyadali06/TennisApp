import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

part 'location_manager_state.dart';

class LocationManagerCubit extends Cubit<LocationManagerState> {
  LocationManagerCubit(this.locationManagerRepo, this.locationRepo)
      : super(LocationManagerInitial());

  final LocationManagerRepo locationManagerRepo;
  final LocationRepo locationRepo;

  Future<void> getLocations() async {
    emit(LocationManagerLoading());
    RequestResult res = await locationManagerRepo.getLocations();
    if (res is RequestSuccess) {
      emit(LocationManagerSuccessed());
    } else if (res is RequestFailed) {
      emit(LocationManagerFailed(res.data));
    }
  }

  Future<void> deleteLocation(PositionEntity positionEntity) async {
    emit(LocationManagerLoading());
    RequestResult res =
        await locationManagerRepo.deleteLoaction(positionEntity);
    if (res is RequestSuccess) {
      emit(LocationManagerSuccessed());
    } else if (res is RequestFailed) {
      emit(LocationManagerFailed(res.data));
    }
  }

  Future<void> setLocationAsDefault(PositionEntity positionEntity) async {
    emit(LocationManagerLoading());
    RequestResult res =
        await locationManagerRepo.setLocationAsDefault(positionEntity);
    if (res is RequestSuccess) {
      emit(LocationManagerSuccessed());
    } else if (res is RequestFailed) {
      emit(LocationManagerFailed(res.data));
    }
  }

  Future<void> handleLocationPermission() async {
    try {
      await locationRepo.handleLocationPermission();
    } catch (_) {}
  }
}
