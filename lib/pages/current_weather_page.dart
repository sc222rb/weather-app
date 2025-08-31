import 'package:flutter/material.dart';
import '../widgets/location.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [LocationWidget(), SizedBox(height: 20)],
        ),
      ),
    );
  }
}