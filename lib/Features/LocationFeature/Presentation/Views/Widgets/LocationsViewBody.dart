import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Widgets/SnackBar.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Domain/Entities/PositionEntity.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/Widgets/MyLocation.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/Widgets/SearchField.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/MyLocationCubit/my_location_cubit.dart';

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

  @override
  void initState() {
    showMyLocationSection = false;
    showSerchFieldSection = false;
    isLoading = false;
    positionEntity = const PositionEntity(longitude: 0, latitude: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyLocationCubit, MyLocationState>(
      listener: (context, state) {
        if (state is CheckLocationLoading) {
          isLoading = true;
          return;
        } else if (state is GetLocationSuccessed) {
          positionEntity = state.positionEntity;
        } else if (state is LocationFailed) {
          showSnackBar(context, state.error.message);
        }
        isLoading = false;
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                                  await BlocProvider.of<MyLocationCubit>(context).checkLocationStatusAsStream(context);
                                  showMyLocationSection = true;
                                  showSerchFieldSection = false;
                                  await BlocProvider.of<MyLocationCubit>(context).getMyLocation();
                                },
                                title: "My Location",
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
                        if (showSerchFieldSection) SearchField(),
                        const SizedBox(height: 30),
                      ],
                    ),
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
