class ForecastWeatherModel {
  final String date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<Hour> hour;

  ForecastWeatherModel({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    return ForecastWeatherModel(
      date: json['date'],
      dateEpoch: json['date_epoch'],
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hour: List<Hour>.from(json['hour'].map((x) => Hour.fromJson(x))),
    );
  }
}

class Day {
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final double avgtempC;
  final double avgtempF;
  final double maxwindMph;
  final double maxwindKph;
  final double totalprecipMm;
  final double totalprecipIn;
  final double totalsnowCm;
  final double avgvisKm;
  final double avgvisMiles;
  final int avghumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final Condition condition;
  final double uv;

  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.totalsnowCm,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c'].toDouble() ?? 0,
      maxtempF: json['maxtemp_f'].toDouble() ?? 0,
      mintempC: json['mintemp_c'].toDouble() ?? 0,
      mintempF: json['mintemp_f'].toDouble() ?? 0,
      avgtempC: json['avgtemp_c'].toDouble() ?? 0,
      avgtempF: json['avgtemp_f'].toDouble() ?? 0,
      maxwindMph: json['maxwind_mph'].toDouble() ?? 0,
      maxwindKph: json['maxwind_kph'].toDouble() ?? 0,
      totalprecipMm: json['totalprecip_mm'].toDouble() ?? 0,
      totalprecipIn: json['totalprecip_in'].toDouble() ?? 0,
      totalsnowCm: json['totalsnow_cm'].toDouble() ?? 0,
      avgvisKm: json['avgvis_km'].toDouble() ?? 0,
      avgvisMiles: json['avgvis_miles'].toDouble() ?? 0,
      avghumidity: json['avghumidity'] ?? 0,
      dailyWillItRain: json['daily_will_it_rain'] ?? 0,
      dailyChanceOfRain: json['daily_chance_of_rain'] ?? 0,
      dailyWillItSnow: json['daily_will_it_snow'] ?? 0,
      dailyChanceOfSnow: json['daily_chance_of_snow'] ?? 0,
      condition: Condition.fromJson(json['condition']),
      uv: json['uv'].toDouble() ?? 0,
    );
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;
  final int isMoonUp;
  final int isSunUp;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'] ?? "",
      sunset: json['sunset'] ?? "",
      moonrise: json['moonrise'] ?? "",
      moonset: json['moonset'] ?? "",
      moonPhase: json['moon_phase'] ?? "",
      moonIllumination: json['moon_illumination'] ?? 0,
      isMoonUp: json['is_moon_up'] ?? 0,
      isSunUp: json['is_sun_up'] ?? 0,
    );
  }
}

class Hour {
  final int timeEpoch;
  final String time;
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
  final double snowCm;
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
  final int willItRain;
  final int chanceOfRain;
  final int willItSnow;
  final int chanceOfSnow;
  final double visKm;
  final double visMiles;
  final double gustMph;
  final double gustKph;
  final double uv;

  Hour({
    required this.timeEpoch,
    required this.time,
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
    required this.snowCm,
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
    required this.willItRain,
    required this.chanceOfRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visKm,
    required this.visMiles,
    required this.gustMph,
    required this.gustKph,
    required this.uv,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      timeEpoch: json['time_epoch'] ?? 0,
      time: json['time'] ?? "",
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
      snowCm: json['snow_cm'].toDouble() ?? 0,
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
      willItRain: json['will_it_rain'] ?? 0,
      chanceOfRain: json['chance_of_rain'] ?? 0,
      willItSnow: json['will_it_snow'] ?? 0,
      chanceOfSnow: json['chance_of_snow'] ?? 0,
      visKm: json['vis_km'].toDouble() ?? 0,
      visMiles: json['vis_miles'].toDouble() ?? 0,
      gustMph: json['gust_mph'].toDouble() ?? 0,
      gustKph: json['gust_kph'].toDouble() ?? 0,
      uv: json['uv'].toDouble() ?? 0,
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
