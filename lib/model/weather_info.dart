class WeatherInfo {
  final double temperature;
  final String city;

  WeatherInfo({
    required this.temperature,
    required this.city,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temperature: (json['main']['temp'] as num).toDouble(),
      city: json['name'],
    );
  }
}
