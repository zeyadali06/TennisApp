import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

String getLatLon(PositionEntity positionEntity) {
  return '${positionEntity.latitude}, ${positionEntity.longitude}';
}
