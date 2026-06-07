import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/AIModelFailureHandler.dart';

abstract class AIModelRepo {
  Future<RequestResult<bool, AIModelFailureHandler>> getPrediction(
      List<int> features);
}
