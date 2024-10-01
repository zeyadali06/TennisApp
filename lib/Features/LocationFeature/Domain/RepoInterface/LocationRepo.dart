import 'package:tennis_app/Core/Failure/RequestFailure.dart';

abstract class LocationRepo {
  Future<RequestResault> getMyLocation();
  Future<RequestResault> searchForPlaces(final String place);
}
