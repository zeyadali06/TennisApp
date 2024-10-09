import 'package:tennis_app/Core/Failure/RequestFailure.dart';

class NoInternetException extends RequestFailed {
  NoInternetException() : super(null);

  final String message = "No Internet Connection!";
}
