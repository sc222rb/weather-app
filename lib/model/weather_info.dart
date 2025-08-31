class WeatherInfo {
  final int temperature;
  final String city;

  WeatherInfo({
    required this.temperature,
    required this.city,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temperature: json['temperature'],
      city: json['city'],
    );
  }
}
