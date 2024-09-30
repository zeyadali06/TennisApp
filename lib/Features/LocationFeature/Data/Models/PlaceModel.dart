class PlaceModel {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      region: json['region'] ?? "",
      country: json['country'] ?? "",
      lat: json['lat'].toDouble() ?? 0,
      lon: json['lon'].toDouble() ?? 0,
      url: json['url'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'url': url,
    };
  }
}
