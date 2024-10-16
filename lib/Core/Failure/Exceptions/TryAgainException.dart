import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class TryAgainException extends RequestFailed {
  TryAgainException() : super(null);

  final String message = "Please, try again";
}
