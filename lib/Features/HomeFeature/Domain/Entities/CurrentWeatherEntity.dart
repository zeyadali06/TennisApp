class CurrentWeatherEntity {
  final double tempC;
  final double windKph;
  final int humidity;
  final double uv;
  final double feelslikeC;
  final double visKm;
  final double pressureMb;
  final String lastUpdated;
  final String icon;

  CurrentWeatherEntity({
    required this.tempC,
    required this.windKph,
    required this.humidity,
    required this.uv,
    required this.feelslikeC,
    required this.visKm,
    required this.pressureMb,
    required this.lastUpdated,
    required this.icon,
  });
}
