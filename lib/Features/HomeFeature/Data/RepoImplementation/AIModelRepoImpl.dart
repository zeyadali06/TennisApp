import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/Check_Network.dart';
import 'package:tennis_app/Core/Failure/AIModelFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Core/Failure/Exceptions/NoInternetException.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/AIModelServices.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/AIModelRepo.dart';

class AIModelRepoImpl extends AIModelRepo {
  AIModelRepoImpl({required this.aiModelServices});

  final AIModelServices aiModelServices;

  @override
  Future<RequestResult<bool, AIModelFailureHandler>> getPrediction(
      List<int> features) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
          AIModelFailureHandler(NoInternetException()),
        );
      }

      bool prediction = await aiModelServices.getPrediction(features);

      return RequestResult.success(prediction);
    } catch (e) {
      return RequestResult.failure(AIModelFailureHandler(TryAgainException()));
    }
  }
}
