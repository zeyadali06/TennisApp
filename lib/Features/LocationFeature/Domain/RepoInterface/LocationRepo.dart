import 'package:tennis_app/Core/Failure/RequestFailure.dart';

abstract class LocationRepo {
  Future<bool> checkLocation();
  Future<RequestResault> getMyLocation();
  Future<RequestResault> searchForPlaces(final String place);
}
