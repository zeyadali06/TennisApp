import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/WeatherIcon.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/StatisticsPieChart.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/TemperatureStatistic.dart';

class WeartherStatistics extends StatelessWidget {
  const WeartherStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          TemperatureStatistic(temperature: 25, minTemperature: -50, maxTemperature: 56.7),
          WeatherIcon(imageUrl: "https://cdn.weatherapi.com/weather/64x64/day/113.png"),
          Expanded(child: SizedBox(height: 20)),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: 1, minValue: 0, maxValue: 11, title: 'UV index'),
                  ),
                ),
              ),
              Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: 14, minValue: 0, maxValue: 200, title: 'Wind(KM/H)'),
                  ),
                ),
              ),
              Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: 56, minValue: 0, maxValue: 100, title: 'Humidity(%)'),
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox(height: 20)),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: -33, minValue: -50, maxValue: 56.7, title: 'Feels Like'),
                  ),
                ),
              ),
              Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: 1014.2, minValue: 870, maxValue: 1085.7, title: 'Pressure'),
                  ),
                ),
              ),
              Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: 9, minValue: 0, maxValue: 30, title: 'Visibility'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
