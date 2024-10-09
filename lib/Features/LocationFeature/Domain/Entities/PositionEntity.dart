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

  @override
  // ignore: non_nullable_equals_parameter, hash_and_equals
  bool operator ==(dynamic other) {
    return other is PositionEntity && other.longitude == longitude && other.latitude == latitude;
  }
}
