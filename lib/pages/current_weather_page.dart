import 'package:flutter/material.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Current Weather',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}