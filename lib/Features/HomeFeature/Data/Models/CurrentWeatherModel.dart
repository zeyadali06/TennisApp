class CurrentWeatherModel {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
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

  CurrentWeatherModel({
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
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      lastUpdatedEpoch: json['last_updated_epoch'] ?? 0,
      lastUpdated: json['last_updated'] ?? "",
      tempC: json['temp_c'].toDouble() ?? 0,
      tempF: json['temp_f'].toDouble() ?? 0,
      isDay: json['is_day'] ?? 0,
      condition: Condition.fromJson(json['condition']),
      windMph: json['wind_mph'].toDouble() ?? 0,
      windKph: json['wind_kph'].toDouble() ?? 0,
      windDegree: json['wind_degree'] ?? 0,
      windDir: json['wind_dir'] ?? "",
      pressureMb: json['pressure_mb'].toDouble() ?? 0,
      pressureIn: json['pressure_in'].toDouble() ?? 0,
      precipMm: json['precip_mm'].toDouble() ?? 0,
      precipIn: json['precip_in'].toDouble() ?? 0,
      humidity: json['humidity'] ?? 0,
      cloud: json['cloud'] ?? 0,
      feelslikeC: json['feelslike_c'].toDouble() ?? 0,
      feelslikeF: json['feelslike_f'].toDouble() ?? 0,
      windchillC: json['windchill_c'].toDouble() ?? 0,
      windchillF: json['windchill_f'].toDouble() ?? 0,
      heatindexC: json['heatindex_c'].toDouble() ?? 0,
      heatindexF: json['heatindex_f'].toDouble() ?? 0,
      dewpointC: json['dewpoint_c'].toDouble() ?? 0,
      dewpointF: json['dewpoint_f'].toDouble() ?? 0,
      visKm: json['vis_km'].toDouble() ?? 0,
      visMiles: json['vis_miles'].toDouble() ?? 0,
      uv: json['uv'].toDouble() ?? 0,
      gustMph: json['gust_mph'].toDouble() ?? 0,
      gustKph: json['gust_kph'].toDouble() ?? 0,
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
