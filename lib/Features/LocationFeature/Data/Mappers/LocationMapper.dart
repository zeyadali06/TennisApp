import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

class LocationMapper {
  static PositionEntity fromPlaceModel(PlaceModel placeModel) {
    return PositionEntity(
      longitude: placeModel.lon,
      latitude: placeModel.lat,
      place: placeModel.name,
      isDefault: false,
    );
  }

  static PositionEntity fromPosition(Position position, String place) {
    return PositionEntity(
      longitude: position.longitude,
      latitude: position.latitude,
      place: place,
      isDefault: false,
    );
  }
}
