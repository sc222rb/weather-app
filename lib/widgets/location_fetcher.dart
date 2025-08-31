import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationFetcher extends StatefulWidget {
  const LocationFetcher({super.key});

  @override
  State<LocationFetcher> createState() => _LocationFetcherState();
}

class _LocationFetcherState extends State<LocationFetcher> {
  String? _locationMessage;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _locationMessage =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } else {
      setState(() {
        _locationMessage = 'Please provide location permission';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _locationMessage ?? 'Fetching location...',
      style: const TextStyle(fontSize: 18),
    );
  }
}