import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

abstract class LocationManagerRepo {
  // Location at index 0 is the default location
  List<PositionEntity> locations = [];

  Future<RequestResault> getLocations();
  Future<RequestResault> addLoaction(PositionEntity positionEntity);
  Future<RequestResault> deleteLoaction(PositionEntity positionEntity);
  Future<RequestResault> setLocationAsDefault(PositionEntity positionEntity);
}
