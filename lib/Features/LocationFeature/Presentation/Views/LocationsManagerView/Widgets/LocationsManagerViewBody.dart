import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/ScaleDown.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Core/Widgets/ViewHeader.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Controllers/HomeViewCubit/home_view_cubit.dart';
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
        if (state is LocationManagerSuccessed) {
          BlocProvider.of<HomeViewCubit>(context)
              .getForecastWeather(BlocProvider.of<HomeViewCubit>(context).date);
        } else if (state is LocationManagerFailed) {
          showSnackBar(context, state.error.message);
        }
      },
      builder: (context, state) {
        List<PositionEntity> locations =
            BlocProvider.of<LocationManagerCubit>(context)
                .locationManagerRepo
                .locations;

        return CustomGradiantContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ViewHeader(),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: locations.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ScaleDown(
                                child: Text(
                                  'No Locations Added',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          bottom: 100,
                        ),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  AppRouter.getRoute(
                                    context,
                                    AppRouter.showLocationOnMapView(
                                      LatLng(
                                        locations[index].latitude,
                                        locations[index].longitude,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: CustomTaskContainer(
                                positionEntity: locations[index],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
