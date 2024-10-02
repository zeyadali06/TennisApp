import 'package:geocoding/geocoding.dart';
import 'package:tennis_app/Core/Functions/GetPlaceMarkAsString.dart';

class PositionEntity {
  final double longitude;
  final double latitude;
  final Placemark placemark;

  const PositionEntity({required this.placemark, required this.longitude, required this.latitude});

  Map<String, dynamic> toMap() {
    return {'longitude': longitude, 'latitude': latitude, 'placemark': getPlaceMarkAsString(placemark)};
  }
}
