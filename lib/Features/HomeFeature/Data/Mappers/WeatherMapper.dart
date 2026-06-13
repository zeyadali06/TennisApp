import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';

class WeatherMapper {
  static WeatherEntity fromWeatherModel(
    WeatherModel weatherModel,
  ) {
    return WeatherEntity(
      tempC: weatherModel.tempC,
      minTempC: weatherModel.minTempC,
      maxTempC: weatherModel.maxTempC,
      windKph: weatherModel.windKph,
      humidity: weatherModel.humidity,
      uv: weatherModel.uv,
      feelslikeC: weatherModel.feelslikeC,
      visKm: weatherModel.visKm,
      pressureMb: weatherModel.pressureMb,
      lastUpdated: weatherModel.lastUpdated,
      icon: weatherModel.condition.icon,
    );
  }
}
