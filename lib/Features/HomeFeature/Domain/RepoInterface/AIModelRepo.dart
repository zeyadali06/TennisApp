import 'package:tennis_app/Core/Failure/RequestFailure.dart';

abstract class AIModelRepo {
  Future<RequestResault> getPrediction(List<int> features);
}
