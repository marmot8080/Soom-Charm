import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  Future<PermissionStatus> checkLocationPermission() async {
    return await Permission.location.request();
  }

  Future<Map<String, dynamic>> fetchWeatherData(Position position) async {
    String apiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY'] ?? '';

    if (apiKey.isEmpty) {
      throw Exception("API 키가 설정되지 않았습니다.");
    }

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric&lang=kr'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}