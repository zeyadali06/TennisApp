import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class EmptyLocationsListException extends RequestFailed {
  EmptyLocationsListException() : super(null);

  final String message = "Choose location first!";
}
