import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tennis_app/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tennis_app/Core/Utils/AppRouter.dart';
import 'package:tennis_app/Core/Utils/DependencyInjection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  await dotenv.load(fileName: "lib/Core/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: AppRouter.navigationBar,
    );
  }
}




// import 'package:flutter/material.dart';
// import 'dart:math';

// class HumidityGauge extends StatelessWidget {
//   final double humidity; // Humidity percentage (0 to 100)

//   HumidityGauge({required this.humidity});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(200, 100), // Adjust the size of the gauge
//       painter: HumidityGaugePainter(humidity),
//     );
//   }
// }

// class HumidityGaugePainter extends CustomPainter {
//   final double humidity;

//   HumidityGaugePainter(this.humidity);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint circlePaint = Paint()
//       ..color = Colors.grey.withOpacity(0.3) // Background color of the gauge
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 10;

//     final Paint arcPaint = Paint()
//       ..color = Colors.blueAccent // Color of the humidity arc
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 10;

//     final center = Offset(size.width / 2, size.height); // Center of the bottom part of the circle
//     final radius = size.width / 2;

//     // Draw the background half circle (grey)
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       pi, // Start at the left
//       pi, // Sweep the arc half a circle
//       false,
//       circlePaint,
//     );

//     // Draw the arc based on the humidity level
//     double sweepAngle = (pi * humidity) / 100;

//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       pi, // Start at the left
//       sweepAngle, // Sweep angle based on humidity percentage
//       false,
//       arcPaint,
//     );

//     // Draw the humidity text in the center
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: '${humidity.toStringAsFixed(0)}%', // Display humidity percentage
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     textPainter.layout(minWidth: 0, maxWidth: size.width);

//     final textOffset = Offset(
//       (size.width - textPainter.width) / 2,
//       size.height / 2 - textPainter.height / 2,
//     );

//     textPainter.paint(canvas, textOffset);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true; // Repaint when humidity changes
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: Text('Humidity Gauge')),
//       body: Center(
//         child: HumidityGauge(humidity: 75), // Set the humidity percentage here
//       ),
//     ),
//   ));
// }
