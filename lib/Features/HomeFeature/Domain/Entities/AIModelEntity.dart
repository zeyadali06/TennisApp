class AIModelEntity {
  final double feelslikeC;
  final int humidity;
  final String conditionText;

  AIModelEntity({
    required this.humidity,
    required this.feelslikeC,
    required this.conditionText,
  });

  factory AIModelEntity.init() {
    return AIModelEntity(
      feelslikeC: 0,
      humidity: 0,
      conditionText: "",
    );
  }

  List<int> getFeatures() {
    List<int> features = [];
    features[0] = conditionText.toLowerCase().contains('rain') ? 1 : 0;
    features[1] = conditionText.toLowerCase().contains('sun') ? 1 : 0;

    if (feelslikeC >= 25) {
      features[2] = 1;
      features[3] = 0;
    } else {
      features[2] = 0;
      features[3] = 1;
    }

    if (humidity >= 30 && humidity <= 50) {
      features[4] = 1;
    } else {
      features[4] = 0;
    }
    return features;
  }
}
