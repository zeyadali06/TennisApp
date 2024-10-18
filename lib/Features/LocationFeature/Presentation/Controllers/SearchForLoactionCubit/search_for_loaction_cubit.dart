import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/UseCases/SearchForLocationsUseCase.dart';

part 'search_for_loaction_state.dart';

class SearchForLoactionCubit extends Cubit<SearchForLoactionState> {
  SearchForLoactionCubit(this.searchForLocationsUseCase) : super(SearchForLoactionInitial());

  final SearchForLocationsUseCase searchForLocationsUseCase;
  String place = "";

  Future<void> searchForLoaction(String place) async {
    emit(SearchForLoactionLoading());

    RequestResault res = await searchForLocationsUseCase.searchForPlaces(place);

    if (res is RequestSuccess) {
      emit(SearchForLoactionSuccessed(res.data));
    } else if (res is RequestFailed) {
      emit(SearchForLoactionFailed(res.data));
    }
  }

  Future<void> choosePositionEntity(PositionEntity positionEntity) async {
    emit(ChooseLocation(positionEntity));
    emit(ChooseLocationFinished());
  }
}
