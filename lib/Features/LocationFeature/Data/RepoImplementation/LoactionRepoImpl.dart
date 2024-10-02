import 'dart:async';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/FirebaseFailureHandler.dart';
import 'package:tennis_app/Core/Failure/GeoLocatorFailureHandler.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Mappers/LocationMapper.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/PlacesServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';
import 'package:tennis_app/Features/AuthFeature/Data/DataSource/FirebaseFirestoreServices.dart';

class LoactionRepoImpl implements LocationRepo {
  LoactionRepoImpl({required this.placesServices});
  PlacesServices placesServices;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  Future<RequestResault<PositionEntity, GeolocatorFailureHandler>> getMyLocation() async {
    final bool hasPermission = await _handlePermission();
    final Position position;

    if (!hasPermission) {
      return RequestResault.failure(GeolocatorFailureHandler(1));
    }

    try {
      position = await _geolocatorPlatform.getCurrentPosition();
      Placemark placemark = await getPlace(position.latitude, position.longitude);
      return RequestResault.success(LocationMapper.toPositionEntity(position, placemark));
    } on LocationServiceDisabledException {
      return RequestResault.failure(GeolocatorFailureHandler(1));
    } catch (e) {
      return RequestResault.failure(GeolocatorFailureHandler(0));
    }
  }

  @override
  Future<RequestResault<void, FirebaseFailureHandler>> addLoaction(PositionEntity poistionEntity) async {
    try {
      await Firestore.setField(collectionPath: ConstantNames.locationsCollection, docName: ConstantNames.userModel.uid!, data: poistionEntity.toMap());
      return RequestResault.success(null);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  @override
  Future<RequestResault<List<String>, WeatherAPIFailureHandler>> searchForPlaces(String place) async {
    try {
      var res = await placesServices.searchForPlaces(place);

      List<String> places = [];

      if (res is List) {
        for (var locationJson in res) {
          places.add(PlaceModel.fromJson(locationJson).name);
        }
      }

      return RequestResault.success(places);
    } on DioException catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(e.response!.data["error"]["code"]));
    } catch (e) {
      return RequestResault.failure(WeatherAPIFailureHandler(0));
    }
  }

  Future<Placemark> getPlace(double latitude, double longitude) async {
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
