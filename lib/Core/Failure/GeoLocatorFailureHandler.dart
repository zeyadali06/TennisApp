import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class GeoLocatorFailureHandler extends RequestFailed {
  late String message;

  GeoLocatorFailureHandler(dynamic e) : super(null) {
    message = e.message;
  }
}
