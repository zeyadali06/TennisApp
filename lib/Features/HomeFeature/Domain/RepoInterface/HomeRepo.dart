import 'package:tennis_app/Core/Failure/RequestFailure.dart';

abstract class HomeRepo {
  Future<RequestResault> getCurrentWeather(String place, int hour);
}
