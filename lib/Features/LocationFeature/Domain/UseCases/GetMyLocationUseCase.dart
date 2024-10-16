import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Core/Failure/GeoLocatorFailureHandler.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/GetPlaceMarkAsString.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Mappers/LocationMapper.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

class GetMyLocationUseCase {
  GetMyLocationUseCase({required this.locationRepo});

  final LocationRepo locationRepo;

  Future<RequestResault<PositionEntity, GeoLocatorFailureHandler>> getMyLocation() async {
    try {
      late Position position;
      late Placemark placemark;

      RequestResault res1 = await locationRepo.getMyPosition();

      if (res1 is RequestSuccess) {
        position = res1.data;
      } else if (res1 is RequestFailed) {
        return RequestResault.failure(res1.data);
      }

      RequestResault res2 = await locationRepo.getMyPlaceMark(position.latitude, position.longitude);

      if (res2 is RequestSuccess) {
        placemark = res2.data;
      } else if (res2 is RequestFailed) {
        return RequestResault.failure(res2.data);
      }

      PositionEntity positionEntity = LocationMapper.fromPosition(position, getPlaceMarkAsString(placemark));
      return RequestResault.success(positionEntity);
    } catch (e) {
      return RequestResault.failure(GeoLocatorFailureHandler(TryAgainException()));
    }
  }
}
