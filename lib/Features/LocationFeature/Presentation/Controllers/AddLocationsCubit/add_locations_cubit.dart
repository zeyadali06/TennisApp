import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

part 'add_locations_state.dart';

class AddLocationsCubit extends Cubit<AddLocationsState> {
  AddLocationsCubit(this.locationManagerRepo) : super(AddLocationsInitial());

  final LocationManagerRepo locationManagerRepo;

  Future<void> addLocation(
      PositionEntity positionEntity, BuildContext context) async {
    // if (!startExecution) {
    //   emit(AddLocationsFailed(FirebaseFailureHandler(
    //       CustomException("Search then choose place or use Get My Location"))));
    //   return;
    // }

    // if (positionEntity.place.isEmpty) {
    //   emit(AddLocationsFailed(FirebaseFailureHandler(
    //       CustomException("Error when getting your location"))));
    //   return;
    // }

    // if (validate) {
    //   if (BlocProvider.of<SearchForLoactionCubit>(context)
    //           .place
    //           .toLowerCase() !=
    //       positionEntity.place.toLowerCase()) {
    //     emit(AddLocationsFailed(FirebaseFailureHandler(
    //         CustomException("Choose place from search results"))));
    //     return;
    //   }
    // }

    emit(AddLocationsLoading());

    RequestResult res = await locationManagerRepo.addLoaction(positionEntity);

    if (res is RequestSuccess) {
      return emit(AddLocationsSuccessed());
    } else if (res is RequestFailed) {
      emit(AddLocationsFailed(res.data));
    }
  }
}
