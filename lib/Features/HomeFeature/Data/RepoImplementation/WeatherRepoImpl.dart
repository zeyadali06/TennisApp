import 'package:dio/dio.dart';
import 'package:tennis_app/Core/Functions/GetLatLon.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/Check_Network.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Core/Failure/Exceptions/NoInternetException.dart';
import 'package:tennis_app/Core/Failure/Exceptions/EmptyLocationListException.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/WeatherRepo.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/ForecastWeatherModel.dart';
import 'package:tennis_app/Core/Failure/Exceptions/WeatherAPIFailureHandlerCodes.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/WeatherApiServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class WeatherRepoImpl extends WeatherRepo {
  WeatherRepoImpl({required this.locationManagerRepo, required this.weatherApiServices});

  final WeatherApiServices weatherApiServices;
  final LocationManagerRepo locationManagerRepo;

  @override
  Future<RequestResault<CurrentWeatherModel, WeatherAPIFailureHandler>> getCurrentWeather() async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(WeatherAPIFailureHandler(NoInternetException()));
      }

      RequestResault res = await _validateLocations();
      if (res is RequestFailed) {
        return RequestResault.failure(res.data);
      }

      String location = getLatLon(locationManagerRepo.locations[0]);
      var response = await weatherApiServices.getCurrentWeather(location, DateTime.now().hour);
      CurrentWeatherModel currentWeatherModel = CurrentWeatherModel.fromJson(response['current']);

      return RequestResault.success(currentWeatherModel);
    } on DioException catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(WeatherAPIFailureHandlerCodes(e.response!.data["error"]["code"])));
    } catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResault<ForecastWeatherModel, WeatherAPIFailureHandler>> getForecastWeather(DateTime dateTime) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(WeatherAPIFailureHandler(NoInternetException()));
      }

      RequestResault res = await _validateLocations();
      if (res is RequestFailed) {
        return RequestResault.failure(res.data);
      }

      String location = getLatLon(locationManagerRepo.locations[0]);
      var response = await weatherApiServices.getForcastWeather(dateTime, location, 1);
      ForecastWeatherModel forecastWeatherModel = ForecastWeatherModel.fromJson(response['forecast']['forecastday'][0]);

      return RequestResault.success(forecastWeatherModel);
    } on DioException catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(WeatherAPIFailureHandlerCodes(e.response!.data["error"]["code"])));
    } catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(TryAgainException()));
    }
  }

  Future<RequestResault<void, WeatherAPIFailureHandler>> _validateLocations() async {
    if (locationManagerRepo.locations.isEmpty) {
      RequestResault res = await locationManagerRepo.getLocations();
      if (res is RequestSuccess) {
        if (res.data.isEmpty) {
          return RequestResault.failure(WeatherAPIFailureHandler(EmptyLocationsListException()));
        }
      } else if (res is RequestFailed) {
        return RequestResault.failure(WeatherAPIFailureHandler(TryAgainException()));
      }
    }
    return RequestResault.success(null);
  }
}
