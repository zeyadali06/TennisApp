import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

abstract class LocationManagerRepo {
  Future<RequestResault> addLoaction(PositionEntity poistionEntity);
  Future<RequestResault> deleteLoaction(PositionEntity poistionEntity);
}
