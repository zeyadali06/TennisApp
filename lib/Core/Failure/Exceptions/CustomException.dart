import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class CustomException extends RequestFailed {
  CustomException(this.message) : super(null);

  final String message;
}
