import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsManagerView/Widgets/ShowLocationOnMapViewBody.dart';

class ShowLocationOnMapView extends StatelessWidget {
  const ShowLocationOnMapView({super.key, required this.coordinates});

  final LatLng coordinates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowLocationOnMapViewBody(coordinates: coordinates),
    );
  }
}
