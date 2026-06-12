import 'package:tennis_app/Core/Utils/Constants.dart';

class PositionEntity {
  final double longitude;
  final double latitude;
  final String place;
  bool isDefault;

  PositionEntity({
    required this.place,
    required this.longitude,
    required this.latitude,
    required this.isDefault,
  });

  factory PositionEntity.fromJson(dynamic data) {
    return PositionEntity(
      longitude: data[Constants.longitudeField],
      latitude: data[Constants.latitudeField],
      place: data[Constants.placeField],
      isDefault: data[Constants.isDefaultField],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Constants.longitudeField: longitude,
      Constants.latitudeField: latitude,
      Constants.placeField: place,
      Constants.isDefaultField: isDefault,
    };
  }

  @override
  // ignore: non_nullable_equals_parameter, hash_and_equals
  bool operator ==(dynamic other) {
    return other is PositionEntity &&
        other.longitude == longitude &&
        other.latitude == latitude;
  }
}
