import 'package:flutter/material.dart';
import 'package:tennis_app/CustomNavigationBar.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/Widgets/LocationSwitch.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key, required this.positionEntity});
  final PositionEntity positionEntity;

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  @override
  void initState() {
    CustomNavigationBarState.enableClean = true;
    super.initState();
  }

  @override
  void dispose() {
    CustomNavigationBarState.enableClean = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LocationSwitch(),
        const SizedBox(height: 15),
        const Text(
          'Your Location:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          'Latitude: ${widget.positionEntity.latitude}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
        Text(
          'Longitude: ${widget.positionEntity.longitude}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ],
    );
  }
}
