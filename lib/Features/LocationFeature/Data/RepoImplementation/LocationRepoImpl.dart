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
  Future<RequestResault<Position, GeoLocatorFailureHandler>> getMyPosition() async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(GeoLocatorFailureHandler(NoInternetException()));
      }

      final bool hasPermission = await _handlePermission();
      if (!hasPermission) {
        return RequestResault.failure(GeoLocatorFailureHandler(LocationPermissionDeniedException()));
      }

      final Position position = await _geolocatorPlatform.getCurrentPosition();
      return RequestResault.success(position);
    } on LocationServiceDisabledException {
      return RequestResault.failure(GeoLocatorFailureHandler(LocationPermissionDeniedException()));
    } catch (e) {
      return RequestResault.failure(GeoLocatorFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResault<Placemark, GeoLocatorFailureHandler>> getMyPlaceMark(double latitude, double longitude) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(GeoLocatorFailureHandler(NoInternetException()));
      }

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      return RequestResault.success(placemarks[0]);
    } catch (e) {
      return RequestResault.failure(GeoLocatorFailureHandler(TryAgainException()));
    }
  }

  @override
  Future<RequestResault<List<PlaceModel>, WeatherAPIFailureHandler>> searchForPlaces(String place) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(WeatherAPIFailureHandler(NoInternetException()));
      }

      var res = await locationServices.searchForPlaces(place);

      List<PlaceModel> places = [];

      if (res is List) {
        for (var locationJson in res) {
          places.add(PlaceModel.fromJson(locationJson));
        }
      }

      return RequestResault.success(places);
    } on DioException catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(WeatherAPIFailureHandlerCodes(e.response!.data["error"]["code"])));
    } catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(TryAgainException()));
    }
  }

  Future<bool> _handlePermission() async {
    LocationPermission permission;

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
