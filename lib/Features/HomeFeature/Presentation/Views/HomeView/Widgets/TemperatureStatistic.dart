import 'dart:math';
import 'package:flutter/material.dart';

class TemperatureStatistic extends StatelessWidget {
  const TemperatureStatistic({super.key, required this.temperature, required this.minTemperature, required this.maxTemperature});

  final double temperature;
  final double minTemperature;
  final double maxTemperature;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 100),
      painter: TemperatureStatisticPainter(
        temperature: temperature,
        minTemperature: minTemperature,
        maxTemperature: maxTemperature,
      ),
    );
  }
}

class TemperatureStatisticPainter extends CustomPainter {
  const TemperatureStatisticPainter({required this.temperature, required this.minTemperature, required this.maxTemperature});

  final double temperature;
  final double minTemperature;
  final double maxTemperature;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final Paint arcPaint = Paint()
      ..color = const Color(0xff044abb)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 6;

    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi, pi, false, circlePaint);

    double validTemperature = temperature.clamp(minTemperature, maxTemperature);
    double percentage = ((validTemperature - minTemperature) / (maxTemperature - minTemperature)) * 100;
    double sweepAngle = (pi * percentage) / 100;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi, sweepAngle, false, arcPaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: "${temperature.toStringAsFixed(0)} ْ C",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      size.height / 2 - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
