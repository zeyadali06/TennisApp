import 'dart:async';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Functions/GetPlaceMarkAsString.dart';
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
      return RequestResault.success(LocationMapper.toPositionEntity(position, getPlaceMarkAsString(placemark)));
    } on LocationServiceDisabledException {
      return RequestResault.failure(GeolocatorFailureHandler(1));
    } catch (e) {
      return RequestResault.failure(GeolocatorFailureHandler(0));
    }
  }

  @override
  Future<RequestResault<void, FirebaseFailureHandler>> addLoaction(PositionEntity poistionEntity) async {
    try {
      var res = await Firestore.getField(collectionPath: ConstantNames.locationsCollection, docName: ConstantNames.userModel.uid!, key: ConstantNames.locationsField);
      bool alreadyExist = false;
      for (var ele in (res as List)) {
        if (PositionEntity.fromJson(ele).compare(poistionEntity)) {
          alreadyExist = true;
          break;
        }
      }
      if (!alreadyExist) {
        res.add(poistionEntity.toMap());
      }
      await Firestore.updateField(collectionPath: ConstantNames.locationsCollection, docName: ConstantNames.userModel.uid!, data: {ConstantNames.locationsField: res});
      return RequestResault.success(null);
    } catch (e) {
      return RequestResault.failure(FirebaseFailureHandler(e));
    }
  }

  @override
  Future<RequestResault<List<PositionEntity>, WeatherAPIFailureHandler>> searchForPlaces(String place) async {
    try {
      var res = await placesServices.searchForPlaces(place);

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
      return RequestResault.failure(WeatherAPIFailureHandler(0));
    }
  }

  @override
  Future<RequestResault> removeLoaction(PositionEntity poistionEntity) {
    // TODO: implement removeLoaction
    throw UnimplementedError();
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
