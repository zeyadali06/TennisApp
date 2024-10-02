import 'package:geocoding/geocoding.dart';

String getPlaceMarkAsString(Placemark placemark) {
  return "${placemark.name ?? ""},${placemark.locality ?? ""},${placemark.country ?? ""}";
}
