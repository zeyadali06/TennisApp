import 'package:tennis_app/Core/Utils/ConstantsNames.dart';

class PositionEntity {
  final double longitude;
  final double latitude;
  final String place;

  const PositionEntity({required this.place, required this.longitude, required this.latitude});

  factory PositionEntity.fromJson(dynamic data) {
    return PositionEntity(
      longitude: data[ConstantNames.longitudeField],
      latitude: data[ConstantNames.latitudeField],
      place: data[ConstantNames.placeField],
    );
  }

  Map<String, dynamic> toMap() {
    return {ConstantNames.longitudeField: longitude, ConstantNames.latitudeField: latitude, ConstantNames.placeField: place};
  }

  bool compare(PositionEntity other) {
    return other.longitude == longitude && other.latitude == latitude;
  }
}
