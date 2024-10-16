import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class LocationAlreadyExistException extends RequestFailed {
  LocationAlreadyExistException() : super(null);

  final String message = "Location already exist";
}
