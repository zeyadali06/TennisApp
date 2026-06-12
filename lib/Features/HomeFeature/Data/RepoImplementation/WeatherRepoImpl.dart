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
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class WeatherRepoImpl extends WeatherRepo {
  WeatherRepoImpl(
      {required this.locationManagerRepo, required this.weatherApiServices});

  final WeatherApiServices weatherApiServices;
  final LocationManagerRepo locationManagerRepo;

  @override
  Future<RequestResult<CurrentWeatherModel, WeatherAPIFailureHandler>>
      getCurrentWeather() async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
            WeatherAPIFailureHandler(NoInternetException()));
      }

      RequestResult res = await _validateLocations();
      if (res is RequestFailed) {
        return RequestResult.failure(res.data);
      }

      PositionEntity? pos = locationManagerRepo.getDefaultPosition();
      if (pos == null) {
        return RequestResult.failure(
            WeatherAPIFailureHandler(EmptyLocationsListException()));
      }

      String location = getLatLon(pos);
      var response = await weatherApiServices.getCurrentWeather(
          location, DateTime.now().hour);
      CurrentWeatherModel currentWeatherModel =
          CurrentWeatherModel.fromJson(response['current']);

      return RequestResult.success(currentWeatherModel);
    } on DioException catch (e) {
      return RequestResult.failure(WeatherAPIFailureHandler(
          WeatherAPIFailureHandlerCodes(e.response!.data["error"]["code"])));
    } catch (e) {
      return RequestResult.failure(
          WeatherAPIFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<ForecastWeatherModel, WeatherAPIFailureHandler>>
      getForecastWeather(DateTime dateTime) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
            WeatherAPIFailureHandler(NoInternetException()));
      }

      RequestResult res = await _validateLocations();
      if (res is RequestFailed) {
        return RequestResult.failure(res.data);
      }

      String location = getLatLon(locationManagerRepo.locations[0]);
      var response =
          await weatherApiServices.getForecastWeather(dateTime, location, 1);
      ForecastWeatherModel forecastWeatherModel =
          ForecastWeatherModel.fromJson(response['forecast']['forecastday'][0]);

      return RequestResult.success(forecastWeatherModel);
    } on DioException catch (e) {
      return RequestResult.failure(WeatherAPIFailureHandler(
          WeatherAPIFailureHandlerCodes(e.response!.data["error"]["code"])));
    } catch (e) {
      return RequestResult.failure(
          WeatherAPIFailureHandler(TryAgainException()));
    }
  }

  Future<RequestResult<void, WeatherAPIFailureHandler>>
      _validateLocations() async {
    if (locationManagerRepo.locations.isEmpty) {
      RequestResult res = await locationManagerRepo.getLocations();
      if (res is RequestSuccess) {
        if (res.data.isEmpty) {
          return RequestResult.failure(
              WeatherAPIFailureHandler(EmptyLocationsListException()));
        }
      } else if (res is RequestFailed) {
        return RequestResult.failure(
            WeatherAPIFailureHandler(TryAgainException()));
      }
    }
    return RequestResult.success(null);
  }
}
