import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

abstract class LocationRepo {
  Future<RequestResault> getMyLocation();
  Future<RequestResault> searchForPlaces(final String place);
  Future<RequestResault> addLoaction(PositionEntity poistionEntity);
}
