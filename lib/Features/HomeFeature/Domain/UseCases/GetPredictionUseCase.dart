import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/AIModelFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Mappers/AIModelMapper.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/AIModelEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/WeatherRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/AIModelRepo.dart';

class GetPredictionUseCase {
  GetPredictionUseCase({required this.aiModelRepo, required this.weatherRepo});

  final AIModelRepo aiModelRepo;
  final WeatherRepo weatherRepo;

  Future<RequestResult<bool, AIModelFailureHandler>> getPrediction() async {
    try {
      late AIModelEntity aiModelEntity;

      RequestResult res = await weatherRepo.getCurrentWeather();

      if (res is RequestSuccess) {
        aiModelEntity = AIModelMapper.fromCurrentWeatherModel(res.data);
      } else if (res is RequestFailed) {
        return RequestResult.failure(AIModelFailureHandler(res.data));
      }

      List<int> features = aiModelEntity.getFeatures();

      return await aiModelRepo.getPrediction(features);
    } on AIModelFailureHandler catch (e) {
      return RequestResult.failure(e);
    } catch (e) {
      return RequestResult.failure(AIModelFailureHandler(TryAgainException()));
    }
  }
}
