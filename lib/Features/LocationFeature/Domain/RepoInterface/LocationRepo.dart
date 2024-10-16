import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/Core/Failure/RequestFailure.dart';
import 'package:tennis_app/Core/Failure/GeoLocatorFailureHandler.dart';
import 'package:tennis_app/Core/Failure/WeatherAPIFailureHandler.dart';
import 'package:tennis_app/Features/LocationFeature/Data/Models/PlaceModel.dart';

abstract class LocationRepo {
  Future<RequestResault<Position, GeoLocatorFailureHandler>> getMyPosition();
  Future<RequestResault<Placemark, GeoLocatorFailureHandler>> getMyPlaceMark(double latitude, double longitude);
  Future<RequestResault<List<PlaceModel>, WeatherAPIFailureHandler>> searchForPlaces(final String place);
}
