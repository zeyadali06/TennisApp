import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/GeoLocatorFailureHandler.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';

abstract class LocationRepo {
  Future<RequestResult<Position, GeoLocatorFailureHandler>> getMyPosition();
  Future<RequestResult<Placemark, GeoLocatorFailureHandler>> getMyPlaceMark(
      double latitude, double longitude);
  Future<RequestResult<List<PlaceModel>, WeatherAPIFailureHandler>>
      searchForPlaces(final String place);
}
