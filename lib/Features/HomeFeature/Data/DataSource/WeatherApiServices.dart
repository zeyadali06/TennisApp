import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';

class WeatherApiServices {
  WeatherApiServices({required this.dio});

  final Dio dio;

  Future getForcastWeather(DateTime dateTime, String place, int numberOfDays) async {
    try {
      String date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
      var response = await dio.request(
        '${ConstantNames.baseURL}forecast.json?q=$place&days=$numberOfDays&dt=$date&hour=${dateTime.hour}&key=${dotenv.env[ConstantNames.apiKey]}',
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

  Future getCurrentWeather(String place, int hour) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '${ConstantNames.baseURL}current.json?q=$place&hour=$hour&key=${dotenv.env[ConstantNames.apiKey]}',
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
