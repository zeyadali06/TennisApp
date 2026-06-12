import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tennis_app/Core/Utils/Constants.dart';

class LocationServices {
  LocationServices({required this.dio});
  Dio dio;

  Future searchForPlaces(String place) async {
    try {
      var response = await dio.request(
        '${Constants.baseURL}search.json?q=$place&key=${dotenv.env[Constants.apiKey]}',
        options: Options(
          method: 'GET',
        ),
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
