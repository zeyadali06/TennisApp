import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/ViewHeader.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/LocationManagerCubit/location_manager_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/AddLocationsCubit/add_locations_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/SearchForLoactionCubit/search_for_loaction_cubit.dart';

class LocationsViewBody extends StatefulWidget {
  const LocationsViewBody({super.key});

  @override
  State<LocationsViewBody> createState() => _LocationsViewBodyState();
}

class _LocationsViewBodyState extends State<LocationsViewBody> {
  late PositionEntity positionEntity;
  late List<PositionEntity> suggestions;

  @override
  void initState() {
    suggestions = [];
    positionEntity =
        PositionEntity(longitude: 0, latitude: 0, place: "", isDefault: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SearchForLoactionCubit, SearchForLoactionState>(
          listener: (context, state) {
            if (state is SearchForLoactionSuccessed) {
              suggestions = state.suggestions;
              showSnackBar(
                  context, "Click on the search field to open suggesstions");
            } else if (state is SearchForLoactionFailed) {
              showSnackBar(context, state.error.message);
            } else if (state is ChooseLocation) {
              positionEntity = state.positionEntity;
            }
            setState(() {});
          },
        ),
        BlocListener<AddLocationsCubit, AddLocationsState>(
          listener: (context, state) {
            if (state is AddLocationsSuccessed) {
              showSnackBar(context, "Location added successfully");
              BlocProvider.of<LocationManagerCubit>(context).getLocations();
            } else if (state is AddLocationsFailed) {
              showSnackBar(context, state.error.message);
            }
          },
        ),
      ],
      child: CustomGradiantContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const ViewHeader(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () async {
                        positionEntity = (await Navigator.push<PositionEntity>(
                          context,
                          AppRouter.getRoute<PositionEntity>(
                            context,
                            AppRouter.mapView,
                          ),
                        ))!;
                        setState(() {});
                      },
                      title: "Get Location",
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (positionEntity.place.isNotEmpty)
                Text(
                  positionEntity.place,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              const Spacer(),
              if (positionEntity.place.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onPressed: () async {
                        await BlocProvider.of<AddLocationsCubit>(context)
                            .addLocation(
                          positionEntity,
                          context,
                        );
                      },
                      title: 'Add This Location',
                    ),
                  ],
                ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
