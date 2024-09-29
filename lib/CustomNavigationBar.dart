import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Core/Widgets/ScaleDown.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 2;
  static List<Widget> pages = <Widget>[];

  @override
  void initState() {
    super.initState();

    pages = <Widget>[
      CustomGradiantContainer(child: Container()),
      CustomGradiantContainer(child: Container()),
      AppRouter.homeView,
      CustomGradiantContainer(child: Container()),
      AppRouter.locationsView,
    ];
  }

  Widget _buildWidget(IconData iconData, int index, String label) {
    bool isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: MaterialButton(
        onPressed: () {
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
            ScaleDown(
              child: Icon(
                iconData,
                shadows: isSelected ? const [Shadow(color: Colors.white, blurRadius: 4)] : null,
                size: isSelected ? 42 : null,
                color: Colors.white,
              ),
            ),
            if (!isSelected)
              ScaleDown(
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: NavigationBar(
                backgroundColor: Colors.grey.withOpacity(.15),
                height: kBottomNavigationBarHeight,
                elevation: 0,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                destinations: <Widget>[
                  _buildWidget(Icons.star_border, 0, 'Fav'),
                  _buildWidget(Icons.admin_panel_settings_outlined, 1, 'Profile'),
                  _buildWidget(Icons.home_filled, 2, 'Home'),
                  _buildWidget(Icons.check_box_outlined, 3, 'Check'),
                  _buildWidget(Icons.location_on, 4, 'Loc'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
