import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherInfo {
  final String city;
  final double temperature;

  WeatherInfo({required this.city, required this.temperature});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      city: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
    );
  }
}

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  WeatherInfo? _weatherInfo;
  bool _loading = true;
  String? _error;

  final String _apiKey = dotenv.env['API_KEY'] ?? '';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _loading = false;
          _error = 'You need to enable location services';
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 0,
        ),
      );

      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$_apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weather = WeatherInfo.fromJson(data);

        setState(() {
          _weatherInfo = weather;
          _loading = false;
        });
      } else {
        setState(() {
          _loading = false;
          _error = 'Failed to retrieve weather information';
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'An error occurred';
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color tempColor(double temp) {
      if (temp <= 0) return Colors.blue;
      if (temp < 20) return Colors.orange;
      return Colors.red;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        color: Colors.blue[50],
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _loading
                  ? const CircularProgressIndicator()
                  : _error != null
                      ? Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red, fontSize: 18),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _weatherInfo!.city,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${_weatherInfo!.temperature.toStringAsFixed(1)}°C',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: tempColor(_weatherInfo!.temperature),
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}