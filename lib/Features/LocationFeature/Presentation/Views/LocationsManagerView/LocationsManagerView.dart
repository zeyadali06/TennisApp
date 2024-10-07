import 'package:flutter/material.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsManagerView/Widgets/LocationsManagerViewBody.dart';

class LocationsManagerView extends StatelessWidget {
  const LocationsManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LocationsManagerViewBody(),
    );
  }
}
