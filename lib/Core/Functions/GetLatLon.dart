import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

String? getLatLon(PositionEntity positionEntity) {
  if (positionEntity.latitude == 1000 && positionEntity.longitude == 1000) {
    return null;
  }
  return '${positionEntity.latitude},${positionEntity.longitude}';
}
