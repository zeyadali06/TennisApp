import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Mappers/LocationMapper.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

class SearchForLocationsUseCase {
  SearchForLocationsUseCase({required this.locationRepo});

  final LocationRepo locationRepo;

  Future<RequestResult<List<PositionEntity>, WeatherAPIFailureHandler>>
      searchForPlaces(String place) async {
    try {
      List<PositionEntity> positions = [];

      RequestResult res1 = await locationRepo.searchForPlaces(place);

      if (res1 is RequestSuccess) {
        for (var position in res1.data as List<PlaceModel>) {
          positions.add(LocationMapper.fromPlaceModel(position));
        }
      } else if (res1 is RequestFailed) {
        return RequestResult.failure(res1.data);
      }

      return RequestResult.success(positions);
    } catch (e) {
      return RequestResult.failure(
          WeatherAPIFailureHandler(TryAgainException()));
    }
  }
}
