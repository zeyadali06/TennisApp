class WeatherModel {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final double minTempC;
  final double minTempF;
  final double maxTempC;
  final double maxTempF;
  final double avgTempC;
  final double avgTempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewpointC;
  final double dewpointF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  WeatherModel({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
    required this.minTempC,
    required this.minTempF,
    required this.maxTempC,
    required this.maxTempF,
    required this.avgTempC,
    required this.avgTempF,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    dynamic data = json['hour'][0];

    return WeatherModel(
      lastUpdatedEpoch: data['last_updated_epoch'] ?? 0,
      lastUpdated: data['last_updated'] ?? "",
      tempC: data['temp_c'].toDouble() ?? 0,
      tempF: data['temp_f'].toDouble() ?? 0,
      isDay: data['is_day'] ?? 0,
      condition: Condition.fromJson(data['condition']),
      windMph: data['wind_mph'].toDouble() ?? 0,
      windKph: data['wind_kph'].toDouble() ?? 0,
      windDegree: data['wind_degree'] ?? 0,
      windDir: data['wind_dir'] ?? "",
      pressureMb: data['pressure_mb'].toDouble() ?? 0,
      pressureIn: data['pressure_in'].toDouble() ?? 0,
      precipMm: data['precip_mm'].toDouble() ?? 0,
      precipIn: data['precip_in'].toDouble() ?? 0,
      humidity: data['humidity'] ?? 0,
      cloud: data['cloud'] ?? 0,
      feelslikeC: data['feelslike_c'].toDouble() ?? 0,
      feelslikeF: data['feelslike_f'].toDouble() ?? 0,
      windchillC: data['windchill_c'].toDouble() ?? 0,
      windchillF: data['windchill_f'].toDouble() ?? 0,
      heatindexC: data['heatindex_c'].toDouble() ?? 0,
      heatindexF: data['heatindex_f'].toDouble() ?? 0,
      dewpointC: data['dewpoint_c'].toDouble() ?? 0,
      dewpointF: data['dewpoint_f'].toDouble() ?? 0,
      visKm: data['vis_km'].toDouble() ?? 0,
      visMiles: data['vis_miles'].toDouble() ?? 0,
      uv: data['uv'].toDouble() ?? 0,
      gustMph: data['gust_mph'].toDouble() ?? 0,
      gustKph: data['gust_kph'].toDouble() ?? 0,
      minTempC: json['day']['mintemp_c'],
      minTempF: json['day']['mintemp_f'],
      maxTempC: json['day']['maxtemp_c'],
      maxTempF: json['day']['maxtemp_f'],
      avgTempC: json['day']['avgtemp_c'],
      avgTempF: json['day']['avgtemp_f'],
    );
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'] ?? "",
      icon: json['icon'] ?? "",
      code: json['code'] ?? 0,
    );
  }
}
