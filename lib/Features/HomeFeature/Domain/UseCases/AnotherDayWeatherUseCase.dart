import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Mappers/WeatherMapper.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/WeatherRepo.dart';

class AnotherDayWeatherUseCase {
  AnotherDayWeatherUseCase({required this.weatherRepo});

  final WeatherRepo weatherRepo;

  Future<RequestResult<WeatherEntity, WeatherAPIFailureHandler>>
      getAnotherDayWeather(DateTime dateTime) async {
    try {
      late WeatherEntity weatherEntity;
      RequestResult res = await weatherRepo.getForecastWeather(dateTime);

      if (res is RequestSuccess) {
        weatherEntity = WeatherMapper.fromWeatherModel(res.data);
        return RequestResult.success(weatherEntity);
      } else if (res is RequestFailed) {
        return RequestResult.failure(res.data);
      } else {
        return RequestResult.failure(
          WeatherAPIFailureHandler(TryAgainException()),
        );
      }
    } on WeatherAPIFailureHandler catch (e) {
      return RequestResult.failure(e);
    } catch (e) {
      return RequestResult.failure(
        WeatherAPIFailureHandler(TryAgainException()),
      );
    }
  }
}
