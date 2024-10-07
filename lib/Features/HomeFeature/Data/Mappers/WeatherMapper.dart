import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/CurrentWeatherEntity.dart';

class WeatherMapper {
  static CurrentWeatherEntity toCurrentWeatherEnitiy(CurrentWeatherModel currentWeatherModel) {
    return CurrentWeatherEntity(
      tempC: currentWeatherModel.tempC,
      windKph: currentWeatherModel.windKph,
      humidity: currentWeatherModel.humidity,
      uv: currentWeatherModel.uv,
      feelslikeC: currentWeatherModel.feelslikeC,
      visKm: currentWeatherModel.visKm,
      pressureMb: currentWeatherModel.pressureMb,
      lastUpdated: currentWeatherModel.lastUpdated,
      icon: currentWeatherModel.condition.icon,
    );
  }
}
