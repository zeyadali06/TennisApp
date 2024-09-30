import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';
import 'package:tennis_app/Features/LocationFeature/Data/DataSource/PlacesServices.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/RepoInterface/LocationRepo.dart';

class LoactionRepoImpl implements LocationRepo {
  LoactionRepoImpl({required this.placesServices});
  PlacesServices placesServices;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  Future<RequestResault<Position, int>> getMyLocation() async {
    final bool hasPermission = await _handlePermission();

    if (!hasPermission) {
      return RequestResault.failure(1);
    }

    final Position position = await _geolocatorPlatform.getCurrentPosition();
    return RequestResault.success(position);
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
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

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
