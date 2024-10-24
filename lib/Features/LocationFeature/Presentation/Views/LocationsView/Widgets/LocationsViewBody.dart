import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Widgets/ViewHeader.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsView/Widgets/MyLocation.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/LocationsView/Widgets/SearchField.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/AddLocationsCubit/add_locations_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/GetMyLocationCubit/get_my_location_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/SearchForLoactionCubit/search_for_loaction_cubit.dart';

class LocationsViewBody extends StatefulWidget {
  const LocationsViewBody({super.key});

  @override
  State<LocationsViewBody> createState() => _LocationsViewBodyState();
}

class _LocationsViewBodyState extends State<LocationsViewBody> {
  late bool showMyLocationSection;
  late bool showSerchFieldSection;
  late PositionEntity positionEntity;
  late List<PositionEntity> suggestions;

  @override
  void initState() {
    showMyLocationSection = false;
    showSerchFieldSection = false;
    suggestions = [];
    positionEntity = const PositionEntity(longitude: 0, latitude: 0, place: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetMyLocationCubit, GetMyLocationState>(
          listener: (context, state) {
            if (state is GetLocationSuccessed) {
              positionEntity = state.positionEntity;
            } else if (state is GetLocationFailed) {
              showSnackBar(context, state.error.message);
            }
          },
        ),
        BlocListener<SearchForLoactionCubit, SearchForLoactionState>(
          listener: (context, state) {
            if (state is SearchForLoactionSuccessed) {
              suggestions = state.suggestions;
              showSnackBar(context, "Click on the search field to open suggesstions");
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
            } else if (state is AddLocationsFailed) {
              showSnackBar(context, state.error.message);
            }
          },
        ),
      ],
      child: CustomGradiantContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
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
                              showMyLocationSection = true;
                              showSerchFieldSection = false;
                              await BlocProvider.of<GetMyLocationCubit>(context).getMyLocation();
                              setState(() {});
                            },
                            title: "Get My Location",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              showMyLocationSection = false;
                              showSerchFieldSection = true;
                              setState(() {});
                            },
                            title: "Search Field",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    if (showMyLocationSection) MyLocation(positionEntity: positionEntity),
                    if (showSerchFieldSection) SearchField(suggestions: suggestions),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    CustomButton(
                      onPressed: () async {
                        bool validate = true;
                        bool startExecution = true;
                        if (!showMyLocationSection && !showSerchFieldSection) {
                          startExecution = false;
                        } else if (showMyLocationSection) {
                          validate = false;
                        }

                        await BlocProvider.of<AddLocationsCubit>(context).addLocation(positionEntity, startExecution, validate, context);
                      },
                      title: 'Add Location',
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
