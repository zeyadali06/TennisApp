import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/ViewHeader.dart';
import 'package:tennis_app/Core/Widgets/CustomGradiantContainer.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/CustomCalendar.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/WeatherStatistics.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: CustomGradiantContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const ViewHeader(),
                  const SizedBox(height: 30),
                  CustomCalendar(onDaySelected: (dateTime) async {}),
                  const SizedBox(height: 30),
                  const WeartherStatistics(),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
