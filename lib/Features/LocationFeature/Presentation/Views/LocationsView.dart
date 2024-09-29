import 'package:flutter/material.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/Widgets/LocationsViewBody.dart';

class LocationsView extends StatelessWidget {
  const LocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LocationsViewBody(),
    );
  }
}
