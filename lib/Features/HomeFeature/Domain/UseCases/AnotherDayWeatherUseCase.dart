import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Mappers/WeatherMapper.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/WeatherRepo.dart';

class AnotherDayWeatherUseCase {
  AnotherDayWeatherUseCase({required this.weatherRepo});

  final WeatherRepo weatherRepo;

  Future<RequestResault<WeatherEntity, WeatherAPIFailureHandler>> getAnotherDayWeather(DateTime dateTime) async {
    try {
      late WeatherEntity weatherEntity;
      RequestResault res = await weatherRepo.getForecastWeather(dateTime);

      if (res is RequestSuccess) {
        weatherEntity = WeatherMapper.fromForecastWeatherModel(res.data);
        return RequestResault.success(weatherEntity);
      } else if (res is RequestFailed) {
        return RequestResault.failure(res.data);
      } else {
        return RequestResault.failure(WeatherAPIFailureHandler(TryAgainException()));
      }
    } on WeatherAPIFailureHandler catch (e) {
      return RequestResault.failure(e);
    } catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(TryAgainException()));
    }
  }
}
