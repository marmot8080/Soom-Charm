import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 추가

class SettingsTestPage extends StatefulWidget {
  @override
  _SettingsTestPageState createState() => _SettingsTestPageState();
}

class _SettingsTestPageState extends State<SettingsTestPage> {
  String _cityName = '';
  String _temperature = '';
  String _condition = '';
  String _windSpeed = '';
  String _windDirection = '';
  String _errorMessage = '';

  Future<void> fetchWeather(double latitude, double longitude) async {
    // .env 파일에서 API 키 불러오기
    String? apiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      setState(() {
        _errorMessage = 'API 키가 설정되지 않았습니다.';
      });
      return;
    }

    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          double temperature = data['main']['temp'];
          String weatherCondition = data['weather'][0]['main'];
          double windSpeed = data['wind']['speed'];
          int windDirection = data['wind']['deg'];

          _condition = (weatherCondition == 'Clear') ? '맑음' : '흐림';
          _temperature = '${temperature.toStringAsFixed(1)}°C';
          _windSpeed = '${windSpeed.toStringAsFixed(1)} m/s';
          _windDirection = '$windDirection°';
          _errorMessage = '';
        });
      } else {
        setState(() {
          _errorMessage = '날씨 정보를 가져오지 못했습니다. 상태 코드: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '에러 발생: $e';
      });
    }
  }

  Future<void> getLocationAndFetchWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _errorMessage = '위치 서비스가 비활성화되어 있습니다.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _errorMessage = '위치 권한이 거부되었습니다.';
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.bestForNavigation),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks.isNotEmpty ? placemarks[0] : Placemark();

    setState(() {
      _cityName = place.locality ?? '지역 이름을 찾을 수 없습니다';
    });

    fetchWeather(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('날씨 정보 조회'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: getLocationAndFetchWeather,
              child: Text('현재 위치로 날씨 조회'),
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (_temperature.isNotEmpty && _condition.isNotEmpty && _cityName.isNotEmpty)
              Column(
                children: [
                  Text('도시: $_cityName'),
                  Text('온도: $_temperature'),
                  Text('날씨: $_condition'),
                  Text('바람: $_windSpeed, 방향: $_windDirection'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}