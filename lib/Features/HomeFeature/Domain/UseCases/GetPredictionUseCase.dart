import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Mappers/AIModelMapper.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/AIModelEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/HomeRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/AIModelRepo.dart';

class GetPredictionUseCase {
  GetPredictionUseCase({required this.aiModelRepo, required this.homeRepo});

  final AIModelRepo aiModelRepo;
  final HomeRepo homeRepo;

  Future<RequestResault> getPrediction() async {
    try {
      late AIModelEntity aiModelEntity;
      var res = await homeRepo.getCurrentWeather();

      if (res is RequestSuccess) {
        CurrentWeatherModel currentWeatherModel = CurrentWeatherModel.fromJson(res.data);
        aiModelEntity = AIModelMapper.fromCurrentWeatherModel(currentWeatherModel);
      } else {
        return RequestResault.failure(res);
      }

      List<int> features = aiModelEntity.getFeatures();

      return await aiModelRepo.getPrediction(features);
    } catch (e) {
      return RequestResault.failure(e);
    }
  }
}
