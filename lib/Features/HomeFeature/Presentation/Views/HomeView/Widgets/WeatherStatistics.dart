import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/WeatherIcon.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/StatisticsPieChart.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/TemperatureStatistic.dart';

class WeartherStatistics extends StatelessWidget {
  const WeartherStatistics({super.key, required this.currentWeatherEntity});

  final WeatherEntity currentWeatherEntity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TemperatureStatistic(temperature: currentWeatherEntity.tempC, minTemperature: -50, maxTemperature: 56.7),
          WeatherIcon(imageUrl: currentWeatherEntity.icon),
          const Expanded(child: SizedBox(height: 20)),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: currentWeatherEntity.uv, minValue: 0, maxValue: 11, title: 'UV index'),
                  ),
                ),
              ),
              const Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: currentWeatherEntity.windKph, minValue: 0, maxValue: 200, title: 'Wind(Kph)'),
                  ),
                ),
              ),
              const Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: currentWeatherEntity.humidity.toDouble(), minValue: 0, maxValue: 100, title: 'Humidity(%)'),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox(height: 20)),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: currentWeatherEntity.feelslikeC, minValue: -50, maxValue: 56.7, title: 'Feels Like'),
                  ),
                ),
              ),
              const Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: currentWeatherEntity.pressureMb, minValue: 870, maxValue: 1085.7, title: 'Pressure'),
                  ),
                ),
              ),
              const Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(value: currentWeatherEntity.visKm, minValue: 0, maxValue: 30, title: 'Visibility'),
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
