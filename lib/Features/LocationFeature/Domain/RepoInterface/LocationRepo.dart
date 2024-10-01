import 'package:flutter/widgets.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';

abstract class LocationRepo {
  Future<bool> checkLocationStatus();
  Future<bool> checkLocationStatusAsStream(BuildContext context);
  Future<void> checkLocationStatusAsStreamDispose();
  Future<bool> openLocationSettings();
  Future<RequestResault> getMyLocation();
  Future<RequestResault> searchForPlaces(final String place);
}
