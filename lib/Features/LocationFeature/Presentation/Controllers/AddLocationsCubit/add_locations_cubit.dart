import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

part 'add_locations_state.dart';

class AddLocationsCubit extends Cubit<AddLocationsState> {
  AddLocationsCubit(this.locationRepo) : super(AddLocationsInitial());

  final LocationRepo locationRepo;

  Future<void> addLocation(PositionEntity poistionEntity) async {
    emit(AddLocationsLoading());
    RequestResault res = await locationRepo.addLoaction(poistionEntity);
    if (res is RequestSuccess) {
      emit(AddLocationsSuccessed());
    } else if (res is RequestFailed) {
      emit(AddLocationsFailed(error: FirebaseFailureHandler(res.data)));
    }
  }
}
