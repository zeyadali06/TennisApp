import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class AIModelFailureHandler extends RequestFailed {
  late String message;

  AIModelFailureHandler(dynamic e) : super(null) {
    message = e.message;
  }
}
