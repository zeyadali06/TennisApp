import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PlaceEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

class LocationMapper {
  static PlaceEntity toPlaceEntity(PlaceModel placeModel) {
    return PlaceEntity(longitude: placeModel.lon, latitude: placeModel.lat, name: placeModel.name, country: placeModel.country);
  }

  static PositionEntity toPositionEntity(Position position, String place) {
    return PositionEntity(longitude: position.longitude, latitude: position.latitude, place: place);
  }
}
