import 'package:dio/dio.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Mappers/WeatherMapper.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/HomeRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/WeatherApiServices.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/CurrentWeatherEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.locationManagerRepo, required this.weatherApiServices});

  final WeatherApiServices weatherApiServices;
  final LocationManagerRepo locationManagerRepo;

  @override
  Future<RequestResault<CurrentWeatherEntity, WeatherAPIFailureHandler>> getCurrentWeather() async {
    try {
      if (locationManagerRepo.locations.isEmpty) {
        var res = await locationManagerRepo.getLocations();
        if (res is RequestSuccess) {
          if (res.data.isEmpty) {
            return RequestResault.failure(WeatherAPIFailureHandler(0));
          }
        } else if (res is RequestFailed) {
          return RequestResault.failure(WeatherAPIFailureHandler(-1));
        }
      }
      
      String location = "${locationManagerRepo.locations[0].latitude},${locationManagerRepo.locations[0].longitude}";
      var response = await weatherApiServices.getCurrentWeather(location, DateTime.now().hour);
      CurrentWeatherModel currentWeatherModel = CurrentWeatherModel.fromJson(response['current']);
      CurrentWeatherEntity currentWeatherEntity = WeatherMapper.toCurrentWeatherEnitiy(currentWeatherModel);
      return RequestResault.success(currentWeatherEntity);
    } on DioException catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(e.response!.data["error"]["code"]));
    } catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(e));
    }
  }
}
