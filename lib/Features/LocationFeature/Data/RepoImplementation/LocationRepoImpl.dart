import 'dart:async';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Failure/NoInternetException.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Functions/Check_Network.dart';
import 'package:tennis_app/Core/Functions/GetPlaceMarkAsString.dart';
import 'package:tennis_app/Core/Failure/GeoLocatorFailureHandler.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Mappers/LocationMapper.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/LocationServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

class LocationRepoImpl implements LocationRepo {
  LocationRepoImpl({required this.locationServices});
  LocationServices locationServices;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  Future<RequestResault<PositionEntity, GeolocatorFailureHandler>> getMyLocation() async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(GeolocatorFailureHandler(NoInternetException()));
      }

      final bool hasPermission = await _handlePermission();
      final Position position;
      if (!hasPermission) {
        return RequestResault.failure(GeolocatorFailureHandler(1));
      }
      position = await _geolocatorPlatform.getCurrentPosition();
      Placemark placemark = await _getPlace(position.latitude, position.longitude);
      return RequestResault.success(LocationMapper.toPositionEntity(position, getPlaceMarkAsString(placemark)));
    } on LocationServiceDisabledException {
      return RequestResault.failure(GeolocatorFailureHandler(1));
    } catch (e) {
      return RequestResault.failure(GeolocatorFailureHandler(0));
    }
  }

  @override
  Future<RequestResault<List<PositionEntity>, WeatherAPIFailureHandler>> searchForPlaces(String place) async {
    try {
      bool connStatus = await checkConn();
      if (!connStatus) {
        return RequestResault.failure(WeatherAPIFailureHandler(NoInternetException()));
      }

      var res = await locationServices.searchForPlaces(place);

      List<PositionEntity> places = [];

      if (res is List) {
        for (var locationJson in res) {
          PlaceModel placeModel = PlaceModel.fromJson(locationJson);
          places.add(PositionEntity(place: placeModel.name, longitude: placeModel.lon, latitude: placeModel.lat));
        }
      }

      return RequestResault.success(places);
    } on DioException catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(e.response!.data["error"]["code"]));
    } catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(e));
    }
  }

  Future<Placemark> _getPlace(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    return placemarks[0];
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
