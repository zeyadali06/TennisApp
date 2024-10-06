import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tennis_app/Core/Widgets/ScaleDownWidget.dart';

class StatisticsPieChart extends StatelessWidget {
  const StatisticsPieChart({super.key, required this.value, required this.maxValue, required this.minValue, required this.title});

  final double value;
  final double maxValue;
  final double minValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    double validValue = value;
    if (value < minValue) {
      validValue = minValue;
    } else if (value > maxValue) {
      validValue = maxValue;
    }

    double difference = maxValue - minValue;
    double percentage = ((validValue - minValue) / (difference)) * 100;

    return Column(
      children: [
        SizedBox(
          height: 70,
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    startDegreeOffset: 90,
                    sections: [
                      PieChartSectionData(
                        radius: 5,
                        showTitle: false,
                        color: const Color(0xff044abb),
                        value: percentage,
                      ),
                      PieChartSectionData(
                        radius: 5,
                        showTitle: false,
                        color: Colors.white,
                        value: 100 - percentage,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FittedWidget(
                    child: Text(
                      value.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
