import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Controllers/HomeViewCubit/home_view_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/AddLocationsCubit/add_locations_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/GetMyLocationCubit/get_my_location_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/LocationManagerCubit/location_manager_cubit.dart';
import 'package:tennis_app/Features/LocationFeature/Presentation/Controllers/SearchForLoactionCubit/search_for_loaction_cubit.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 2;
  List<Widget> pages = <Widget>[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    pages = <Widget>[
      CustomGradiantContainer(child: Container()),
      CustomGradiantContainer(child: Container()),
      AppRouter.homeView,
      AppRouter.locationsManagerView,
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
            FittedWidget(
              child: Icon(
                iconData,
                shadows: isSelected ? const [Shadow(color: Colors.white, blurRadius: 4)] : null,
                size: isSelected ? 42 : null,
                color: Colors.white,
              ),
            ),
            if (!isSelected)
              FittedWidget(
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
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeViewCubit, HomeViewState>(
          listener: (context, state) {
            if (state is HomeViewLoading) {
              isLoading = true;
            } else {
              isLoading = false;
            }
            setState(() {});
          },
        ),
        BlocListener<AddLocationsCubit, AddLocationsState>(
          listener: (context, state) {
            if (state is AddLocationsLoading) {
              isLoading = true;
            } else {
              isLoading = false;
            }
            setState(() {});
          },
        ),
        BlocListener<GetMyLocationCubit, GetMyLocationState>(
          listener: (context, state) {
            if (state is CheckLocationLoading) {
              isLoading = true;
            } else {
              isLoading = false;
            }
            setState(() {});
          },
        ),
        BlocListener<SearchForLoactionCubit, SearchForLoactionState>(
          listener: (context, state) {
            if (state is SearchForLoactionLoading) {
              isLoading = true;
            } else {
              isLoading = false;
            }
            setState(() {});
          },
        ),
        BlocListener<LocationManagerCubit, LocationManagerState>(
          listener: (context, state) {
            if (state is LocationManagerLoading) {
              isLoading = true;
            } else {
              isLoading = false;
            }
            setState(() {});
          },
        ),
      ],
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                    color: const Color(0xff191e37),
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
        ),
      ),
    );
  }
}
