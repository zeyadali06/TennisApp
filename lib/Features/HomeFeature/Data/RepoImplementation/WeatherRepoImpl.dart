import 'package:dio/dio.dart';
import 'package:tennis_app/Core/Failure/Exceptions/CustomException.dart';
import 'package:tennis_app/Core/Functions/GetLatLon.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/Check_Network.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Core/Failure/Exceptions/NoInternetException.dart';
import 'package:tennis_app/Core/Failure/Exceptions/EmptyLocationListException.dart';
import 'package:tennis_app/Features/HomeFeature/Data/Models/CurrentWeatherModel.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/RepoInterface/WeatherRepo.dart';
import 'package:tennis_app/Core/Failure/Exceptions/WeatherAPIFailureHandlerCodes.dart';
import 'package:tennis_app/Features/HomeFeature/Data/DataSource/WeatherApiServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationManagerRepo.dart';

class WeatherRepoImpl extends WeatherRepo {
  WeatherRepoImpl({
    required this.locationManagerRepo,
    required this.weatherApiServices,
  });

  final WeatherApiServices weatherApiServices;
  final LocationManagerRepo locationManagerRepo;

  @override
  Future<RequestResult<WeatherModel, WeatherAPIFailureHandler>>
      getForecastWeather(DateTime dateTime) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
          WeatherAPIFailureHandler(NoInternetException()),
        );
      }

      final RequestResult res = await _validateLocations();
      if (res is RequestFailed) {
        return RequestResult.failure(res.data);
      }

      String location =
          getLatLon(locationManagerRepo.locations.firstWhere((pos) {
        return pos.isDefault;
      }, orElse: () => PositionEntity.init()));

      if (location.isEmpty) {
        return RequestResult.failure(
          WeatherAPIFailureHandler(CustomException("Choose location first!")),
        );
      }

      var response =
          await weatherApiServices.getForecastWeather(dateTime, location, 1);
      WeatherModel forecastWeatherModel =
          WeatherModel.fromJson(response['forecast']['forecastday'][0]);

      return RequestResult.success(forecastWeatherModel);
    } on DioException catch (e) {
      return RequestResult.failure(
        WeatherAPIFailureHandler(
            WeatherAPIFailureHandlerCodes(e.response!.data["error"]["code"])),
      );
    } catch (e) {
      return RequestResult.failure(
        WeatherAPIFailureHandler(TryAgainException()),
      );
    }
  }

  Future<RequestResult<void, WeatherAPIFailureHandler>>
      _validateLocations() async {
    if (locationManagerRepo.locations.isEmpty) {
      final RequestResult res = await locationManagerRepo.getLocations();
      if (res is RequestSuccess) {
        if (res.data.isEmpty) {
          return RequestResult.failure(
            WeatherAPIFailureHandler(EmptyLocationsListException()),
          );
        }
      } else if (res is RequestFailed) {
        return RequestResult.failure(
          WeatherAPIFailureHandler(TryAgainException()),
        );
      }
    }
    return RequestResult.success(null);
  }
}
