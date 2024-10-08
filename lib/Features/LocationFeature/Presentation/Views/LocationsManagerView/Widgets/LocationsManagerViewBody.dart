import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Widgets/ScaleDown.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsManagerView/Widgets/CustomTaskContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/LocationManagerCubit/location_manager_cubit.dart';

// ignore: must_be_immutable
class LocationsManagerViewBody extends StatelessWidget {
  const LocationsManagerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationManagerCubit, LocationManagerState>(
      listener: (context, state) {
        if (state is LocationManagerFailed) {
          showSnackBar(context, state.error.message);
        }
      },
      builder: (context, state) {
        List<PositionEntity> locations = BlocProvider.of<LocationManagerCubit>(context).locationManagerRepo.locations;
        return CustomGradiantContainer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const FittedWidget(
                        child: Text(
                          'Default Location',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (locations.isNotEmpty)
                        CustomTaskContainer(
                          positionEntity: locations.first,
                          isNotDeafult: false,
                        ),
                      if (locations.isEmpty)
                        const Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScaleDown(
                              child: Text(
                                'No Locations Found',
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 30),
                      const FittedWidget(
                        child: Text(
                          'Another Locations',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (locations.length <= 1)
                        const Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScaleDown(
                              child: Text(
                                'No Locations Found',
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      if (locations.length > 1)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: locations.length - 1,
                          itemBuilder: (context, index) {
                            return CustomTaskContainer(positionEntity: locations[index + 1], isNotDeafult: true);
                          },
                        ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
