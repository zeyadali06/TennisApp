import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

part 'search_for_loaction_state.dart';

class SearchForLoactionCubit extends Cubit<SearchForLoactionState> {
  SearchForLoactionCubit(this.locationRepo) : super(SearchForLoactionInitial());

  final LocationRepo locationRepo;
  String place = "";

  Future<void> searchForLoaction(String place) async {
    emit(SearchForLoactionLoading());

    RequestResault res = await locationRepo.searchForPlaces(place);

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
