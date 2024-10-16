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
    features.add(conditionText.toLowerCase().contains('rain') ? 1 : 0);
    features.add(conditionText.toLowerCase().contains('sun') ? 1 : 0);

    if (feelslikeC >= 25) {
      features.add(1);
      features.add(0);
    } else {
      features.add(0);
      features.add(1);
    }

    if (humidity >= 30 && humidity <= 50) {
      features.add(1);
    } else {
      features.add(0);
    }
    return features;
  }
}
