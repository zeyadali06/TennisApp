import 'package:flutter/material.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';
import 'package:tennis_app/Features/HomeFeature/Domain/Entities/WeatherEntity.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/WeatherIcon.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/StatisticsPieChart.dart';
import 'package:tennis_app/Features/HomeFeature/Presentation/Views/HomeView/Widgets/TemperatureStatistic.dart';

class WeartherStatistics extends StatelessWidget {
  const WeartherStatistics({super.key, required this.weatherEntity});

  final WeatherEntity weatherEntity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TemperatureStatistic(
            temperature: weatherEntity.tempC,
            minTemperature: -50,
            maxTemperature: 56.7,
          ),
          WeatherIcon(imageUrl: weatherEntity.icon),
          const SizedBox(height: 20),
          Text(
            "${weatherEntity.maxTempC.toInt()} ْ C  /  ${weatherEntity.minTempC.toInt()} ْ C",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(
                      value: weatherEntity.uv,
                      minValue: 0,
                      maxValue: 11,
                      title: 'UV index',
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(
                      value: weatherEntity.windKph,
                      minValue: 0,
                      maxValue: 200,
                      title: 'Wind(Kph)',
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(
                      value: weatherEntity.humidity.toDouble(),
                      minValue: 0,
                      maxValue: 100,
                      title: 'Humidity(%)',
                    ),
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
                    child: StatisticsPieChart(
                      value: weatherEntity.feelslikeC,
                      minValue: -50,
                      maxValue: 56.7,
                      title: 'Feels Like( ْ C)',
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(
                      value: weatherEntity.pressureMb,
                      minValue: 870,
                      maxValue: 1085.7,
                      title: 'Pressure',
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox(width: 10)),
              Flexible(
                flex: 5,
                child: Center(
                  child: FittedWidget(
                    child: StatisticsPieChart(
                      value: weatherEntity.visKm,
                      minValue: 0,
                      maxValue: 30,
                      title: 'Visibility',
                    ),
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
