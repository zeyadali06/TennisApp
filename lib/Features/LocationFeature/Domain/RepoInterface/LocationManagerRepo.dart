import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

abstract class LocationManagerRepo {
  // Location at index 0 is the default location
  List<PositionEntity> locations = [];

  Future<RequestResult<List<PositionEntity>, FirebaseFailureHandler>>
      getLocations();
  Future<RequestResult<List<PositionEntity>, FirebaseFailureHandler>>
      addLoaction(PositionEntity positionEntity);
  Future<RequestResult<List<PositionEntity>, FirebaseFailureHandler>>
      deleteLoaction(PositionEntity positionEntity);
  Future<RequestResult<List<PositionEntity>, FirebaseFailureHandler>>
      setLocationAsDefault(PositionEntity positionEntity);
  PositionEntity? getDefaultPosition();
}
