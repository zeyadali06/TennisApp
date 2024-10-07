import 'package:dio/dio.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Mappers/WeatherMapper.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/HomeRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/WeatherApiServices.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/CurrentWeatherEntity.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.weatherApiServices});

  final WeatherApiServices weatherApiServices;

  @override
  Future<RequestResault<CurrentWeatherEntity, WeatherAPIFailureHandler>> getCurrentWeather(String place, int hour) async {
    try {
      var res = await weatherApiServices.getCurrentWeather(place, hour);
      CurrentWeatherModel currentWeatherModel = CurrentWeatherModel.fromJson(res['current']);
      CurrentWeatherEntity currentWeatherEntity = WeatherMapper.toCurrentWeatherEnitiy(currentWeatherModel);
      return RequestResault.success(currentWeatherEntity);
    } on DioException catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(e.response!.data["error"]["code"]));
    } catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(0));
    }
  }
}
