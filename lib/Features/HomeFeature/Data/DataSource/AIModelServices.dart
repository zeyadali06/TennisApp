import 'dart:convert';
import 'package:dio/dio.dart';

class AIModelServices {
  AIModelServices({required this.dio});

  final Dio dio;

  Future getPrediction(List<int> features) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"features": features});

      var response = await dio.request(
        '10.0.2.2:5001/predict',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.statusMessage;
      }
    } catch (e) {
      rethrow;
    }
  }
}
