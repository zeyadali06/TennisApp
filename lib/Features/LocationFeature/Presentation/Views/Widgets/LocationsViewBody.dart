import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';
import 'package:tennis_app/Core/Widgets/CustomButton.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/Widgets/MyLocation.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Views/Widgets/SearchField.dart';

class LocationsViewBody extends StatefulWidget {
  const LocationsViewBody({super.key});

  @override
  State<LocationsViewBody> createState() => _LocationsViewBodyState();
}

class _LocationsViewBodyState extends State<LocationsViewBody> {
  late bool showMyLocationSection;
  late bool showSerchFieldSection;
  @override
  void initState() {
    showMyLocationSection = false;
    showSerchFieldSection = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomGradiantContainer(
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
                          onPressed: () {
                            showMyLocationSection = true;
                            showSerchFieldSection = false;
                            setState(() {});
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
                  if (showMyLocationSection) const MyLocation(latitude: 48.8567, longitude: 2.3508),
                  if (showSerchFieldSection) SearchField(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
