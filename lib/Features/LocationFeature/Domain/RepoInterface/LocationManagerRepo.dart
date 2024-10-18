import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

abstract class LocationManagerRepo {
  // Location at index 0 is the default location
  List<PositionEntity> locations = [];

  Future<RequestResault<List<PositionEntity>, FirebaseFailureHandler>> getLocations();
  Future<RequestResault<List<PositionEntity>, FirebaseFailureHandler>> addLoaction(PositionEntity positionEntity);
  Future<RequestResault<List<PositionEntity>, FirebaseFailureHandler>> deleteLoaction(PositionEntity positionEntity);
  Future<RequestResault<List<PositionEntity>, FirebaseFailureHandler>> setLocationAsDefault(PositionEntity positionEntity);
}
