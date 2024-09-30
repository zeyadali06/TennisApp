import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';

class PlacesServices {
  PlacesServices({required this.dio});
  Dio dio;

  Future<String?> searchForPlaces(String place) async {
    var response = await dio.request(
      '${ConstantNames.baseURL}search.json?q=$place&key=${dotenv.env[ConstantNames.apiKey]}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return json.encode(response.data);
    } else {
      return response.statusMessage;
    }
  }
}
