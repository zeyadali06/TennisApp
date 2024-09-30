import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/ScaleDown.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key, required this.longitude, required this.latitude});
  final double longitude;
  final double latitude;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.yellow),
            ScaleDown(
              child: Text(
                "Enable location from settings.",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'Your Location:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          'Latitude: $latitude',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
        Text(
          'Longitude: $longitude',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ],
    );
  }
}
