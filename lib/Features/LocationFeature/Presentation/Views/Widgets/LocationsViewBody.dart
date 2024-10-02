import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tennis_app/Core/Functions/SnackBar.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/Widgets/MyLocation.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/Widgets/SearchField.dart';
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
  late bool isLoading;
  late PositionEntity positionEntity;
  late List<String> suggestions;

  @override
  void initState() {
    showMyLocationSection = false;
    showSerchFieldSection = false;
    isLoading = false;
    suggestions = [];
    positionEntity = const PositionEntity(longitude: 0, latitude: 0, placemark: Placemark());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetMyLocationCubit, GetMyLocationState>(
          listener: (context, state) {
            if (state is CheckLocationLoading) {
              isLoading = true;
              return setState(() {});
            } else if (state is GetLocationSuccessed) {
              positionEntity = state.positionEntity;
            } else if (state is GetLocationFailed) {
              showSnackBar(context, state.error.message);
            }
            isLoading = false;
            setState(() {});
          },
        ),
        BlocListener<SearchForLoactionCubit, SearchForLoactionState>(
          listener: (context, state) {
            if (state is SearchForLoactionLoading) {
              isLoading = true;
              return setState(() {});
            } else if (state is SearchForLoactionSuccessed) {
              suggestions = state.suggestions;
            } else if (state is SearchForLoactionFailed) {
              showSnackBar(context, state.error.message);
            }
            isLoading = false;
            setState(() {});
          },
        ),
      ],
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: CustomGradiantContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Hello',
                        style: TextStyle(color: Color(0xff0053bd), fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ConstantNames.userModel.fullName.toString(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () async {
                                showMyLocationSection = true;
                                showSerchFieldSection = false;
                                await BlocProvider.of<GetMyLocationCubit>(context).getMyLocation();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
