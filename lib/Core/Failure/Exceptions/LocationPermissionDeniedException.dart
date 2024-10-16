import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class LocationPermissionDeniedException extends RequestFailed {
  LocationPermissionDeniedException() : super(null);

  final String message = "Location Permission Denied!";
}
