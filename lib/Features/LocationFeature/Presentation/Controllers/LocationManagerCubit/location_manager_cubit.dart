import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

part 'location_manager_state.dart';

class LocationManagerCubit extends Cubit<LocationManagerState> {
  LocationManagerCubit(this.locationManagerRepo) : super(LocationManagerInitial());

  final LocationManagerRepo locationManagerRepo;

  Future<void> getLocations() async {
    emit(LocationManagerLoading());
    RequestResault res = await locationManagerRepo.getLocations();
    if (res is RequestSuccess) {
      emit(LocationManagerSuccessed());
    } else if (res is RequestFailed) {
      emit(LocationManagerFailed(res.data));
    }
  }

  Future<void> deleteLocation(PositionEntity positionEntity) async {
    emit(LocationManagerLoading());
    RequestResault res = await locationManagerRepo.deleteLoaction(positionEntity);
    if (res is RequestSuccess) {
      emit(LocationManagerSuccessed());
    } else if (res is RequestFailed) {
      emit(LocationManagerFailed(res.data));
    }
  }

  Future<void> setLocationAsDefault(PositionEntity positionEntity) async {
    emit(LocationManagerLoading());
    RequestResault res = await locationManagerRepo.setLocationAsDefault(positionEntity);
    if (res is RequestSuccess) {
      emit(LocationManagerSuccessed());
    } else if (res is RequestFailed) {
      emit(LocationManagerFailed(res.data));
    }
  }
}
