import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/SearchForLoactionCubit/search_for_loaction_cubit.dart';

part 'add_locations_state.dart';

class AddLocationsCubit extends Cubit<AddLocationsState> {
  AddLocationsCubit(this.locationManagerRepo) : super(AddLocationsInitial());

  final LocationManagerRepo locationManagerRepo;

  Future<void> addLocation(PositionEntity positionEntity, bool validate, BuildContext context) async {
    if (validate) {
      if (positionEntity.place.isEmpty) {
        emit(AddLocationsValidationFailed("Search then choose place"));
        return;
      }

      if (BlocProvider.of<SearchForLoactionCubit>(context).place.toLowerCase() != positionEntity.place.toLowerCase()) {
        emit(AddLocationsValidationFailed("Choose place from search results"));
        return;
      }
    }

    emit(AddLocationsLoading());

    RequestResault res = await locationManagerRepo.addLoaction(positionEntity);

    if (res is RequestSuccess) {
      emit(AddLocationsSuccessed());
    } else if (res is RequestFailed) {
      if (res.data is String) {
        emit(AddLocationsValidationFailed(res.data));
      } else if (res.data is FirebaseFailureHandler) {
        emit(AddLocationsFailed(res.data));
      }
    }
  }
}
