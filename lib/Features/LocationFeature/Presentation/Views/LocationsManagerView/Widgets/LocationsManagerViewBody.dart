import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsManagerView/Widgets/CustomTaskContainer.dart';

class LocationsManagerViewBody extends StatelessWidget {
  const LocationsManagerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradiantContainer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: const [
            SizedBox(height: 20),
            CustomTaskContainer(positionEntity: PositionEntity(place: 'Cairo', longitude: 30.70, latitude: 30.70), isDeafult: true),
          ],
        ),
      ),
    );
  }
}
