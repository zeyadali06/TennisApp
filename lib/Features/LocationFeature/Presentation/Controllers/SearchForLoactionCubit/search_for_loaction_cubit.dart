import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/UseCases/SearchForLocationsUseCase.dart';

part 'search_for_loaction_state.dart';

class SearchForLocationCubit extends Cubit<SearchForLocationState> {
  SearchForLocationCubit(this.searchForLocationsUseCase)
      : super(SearchForLocationInitial());

  final SearchForLocationsUseCase searchForLocationsUseCase;
  String place = "";

  Future<void> searchForLocation(String place) async {
    emit(SearchForLocationLoading());

    RequestResult res = await searchForLocationsUseCase.searchForPlaces(place);

    if (res is RequestSuccess) {
      emit(SearchForLocationSuccessed(res.data));
    } else if (res is RequestFailed) {
      emit(SearchForLocationFailed(res.data));
    }
  }

  Future<void> choosePositionEntity(PositionEntity positionEntity) async {
    emit(ChooseLocation(positionEntity));
    emit(ChooseLocationFinished());
  }
}
