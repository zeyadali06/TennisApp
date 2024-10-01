import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/MyLocationCubit/my_location_cubit.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 2;
  bool wasOnLocationsView = false;
  List<Widget> pages = <Widget>[];
  static late bool enableClean;

  @override
  void initState() {
    super.initState();

    enableClean = false;
    pages = <Widget>[
      CustomGradiantContainer(child: Container()),
      CustomGradiantContainer(child: Container()),
      AppRouter.homeView,
      CustomGradiantContainer(child: Container()),
      AppRouter.locationsView,
    ];
  }

  void clean() async {
    if (wasOnLocationsView) {
      await BlocProvider.of<MyLocationCubit>(context).closeStatusStream(context);
    }
  }

  Widget _buildWidget(IconData iconData, int index, String label) {
    bool isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: MaterialButton(
        onPressed: () {
          if (selectedIndex == 4) {
            wasOnLocationsView = true;
          } else {
            wasOnLocationsView = false;
          }

          if (enableClean) {
            clean();
          }

          selectedIndex = index;
          setState(() {});
        },
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        hoverColor: Colors.grey.withOpacity(.2),
        highlightColor: Colors.grey.withOpacity(.2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                iconData,
                shadows: isSelected ? const [Shadow(color: Colors.white, blurRadius: 4)] : null,
                size: isSelected ? 42 : null,
                color: Colors.white,
              ),
            ),
            if (!isSelected)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w300),
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages.elementAt(selectedIndex),
          Positioned(
            bottom: 15,
            right: 20,
            left: 20,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(.15),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildWidget(Icons.star_border, 0, 'Fav')),
                  Expanded(child: _buildWidget(Icons.admin_panel_settings_outlined, 1, 'Profile')),
                  Expanded(child: _buildWidget(Icons.home_filled, 2, 'Home')),
                  Expanded(child: _buildWidget(Icons.check_box_outlined, 3, 'Check')),
                  Expanded(child: _buildWidget(Icons.location_on, 4, 'Loc')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
