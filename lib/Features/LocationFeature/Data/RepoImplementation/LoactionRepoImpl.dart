import 'dart:async';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Mappers/LocationMapper.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/PlacesServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

class LoactionRepoImpl implements LocationRepo {
  LoactionRepoImpl({required this.placesServices});
  PlacesServices placesServices;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  late StreamSubscription<ServiceStatus> statusStream;

  @override
  Future<RequestResault<PositionEntity, int>> getMyLocation() async {
    final bool hasPermission = await _handlePermission();
    final Position position;

    if (!hasPermission) {
      return RequestResault.failure(1);
    }

    try {
      position = await _geolocatorPlatform.getCurrentPosition();
      return RequestResault.success(LocationMapper.toPositionEntity(position));
    } on LocationServiceDisabledException {
      return RequestResault.failure(1);
    } catch (e) {
      return RequestResault.failure(0);
    }
  }

  @override
  Future<RequestResault<List<String>, int>> searchForPlaces(String place) async {
    try {
      var res = await placesServices.searchForPlaces(place);

      List<String> places = [];

      res.map((locationJson) {
        places.add(PlaceModel.fromJson(locationJson).name);
      });

      return RequestResault.success(places);
    } on DioException catch (e) {
      return RequestResault.failure(e.response!.data["error"]["code"]);
    } catch (e) {
      return RequestResault.failure(0);
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
