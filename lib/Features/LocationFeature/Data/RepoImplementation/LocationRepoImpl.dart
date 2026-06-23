import 'dart:async';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/Check_Network.dart';
import 'package:tennis_app/Core/Failure/GeoLocatorFailureHandler.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Core/Failure/Exceptions/TryAgainException.dart';
import 'package:tennis_app/Core/Failure/Exceptions/NoInternetException.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';
import 'package:tennis_app/Core/Failure/Exceptions/WeatherAPIFailureHandlerCodes.dart';
import 'package:tennis_app/Core/Failure/Exceptions/LocationPermissionDeniedException.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/LocationServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

class LocationRepoImpl implements LocationRepo {
  LocationRepoImpl({required this.locationServices});
  LocationServices locationServices;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  Future<RequestResult<Position, GeoLocatorFailureHandler>>
      getMyPosition() async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
            GeoLocatorFailureHandler(NoInternetException()));
      }

      final RequestResult res = await handleLocationPermission();
      if (res is RequestFailed) {
        return RequestResult.failure(
          GeoLocatorFailureHandler(LocationPermissionDeniedException()),
        );
      }

      final Position position = await _geolocatorPlatform.getCurrentPosition();
      return RequestResult.success(position);
    } on LocationServiceDisabledException {
      return RequestResult.failure(
        GeoLocatorFailureHandler(LocationPermissionDeniedException()),
      );
    } catch (e) {
      return RequestResult.failure(
          GeoLocatorFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<Placemark, GeoLocatorFailureHandler>> getMyPlaceMark(
      double latitude, double longitude) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
            GeoLocatorFailureHandler(NoInternetException()));
      }

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      return RequestResult.success(placemarks[0]);
    } catch (e) {
      return RequestResult.failure(
          GeoLocatorFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<List<PlaceModel>, WeatherAPIFailureHandler>>
      searchForPlaces(String place) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResult.failure(
            WeatherAPIFailureHandler(NoInternetException()));
      }

      var res = await locationServices.searchForPlaces(place);

      List<PlaceModel> places = [];

      if (res is List) {
        for (var locationJson in res) {
          places.add(PlaceModel.fromJson(locationJson));
        }
      }

      return RequestResult.success(places);
    } on DioException catch (e) {
      return RequestResult.failure(WeatherAPIFailureHandler(
          WeatherAPIFailureHandlerCodes(e.response!.data["error"]["code"])));
    } catch (e) {
      return RequestResult.failure(
          WeatherAPIFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResult<void, GeoLocatorFailureHandler>>
      handleLocationPermission() async {
    try {
      LocationPermission permission;

      permission = await _geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _geolocatorPlatform.requestPermission();
        if (permission == LocationPermission.denied) {
          return RequestResult.failure(
            GeoLocatorFailureHandler(LocationPermissionDeniedException()),
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return RequestResult.failure(
          GeoLocatorFailureHandler(LocationPermissionDeniedException()),
        );
      }

      return RequestResult.success(null);
    } catch (e) {
      return RequestResult.failure(
        GeoLocatorFailureHandler(LocationPermissionDeniedException()),
      );
    }
  }
}
