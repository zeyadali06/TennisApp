import 'package:flutter/material.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key, required this.positionEntity});
  final PositionEntity positionEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Your Location:',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Place: ${positionEntity.place}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
        const SizedBox(height: 10),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Latitude: ${positionEntity.latitude}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
        const SizedBox(height: 10),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Longitude: ${positionEntity.longitude}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
