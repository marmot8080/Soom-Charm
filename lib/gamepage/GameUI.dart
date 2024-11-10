import 'package:contact/gamepage/weather/Rain_UI.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Air_Bower_Game.dart';
import 'package:permission_handler/permission_handler.dart'; // permission_handler 추가
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 추가

class GameUI extends StatefulWidget {
  @override
  _GameUIState createState() => _GameUIState();
}

class _GameUIState extends State<GameUI> {
  double? windStrength;
  String? cityName;
  double? temperature;
  String? weatherDescription;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndFetchData();
  }

  // 위치 권한 확인 및 날씨 데이터를 가져오는 함수
  Future<void> _checkPermissionsAndFetchData() async {
    // 위치 권한 요청
    PermissionStatus locationPermission = await Permission.location.request();

    if (locationPermission.isGranted) {
      // 권한이 허용되면 위치 정보 가져오기
      _fetchLocationAndWeatherData();
    } else {
      // 권한이 거부되었을 경우
      _showPermissionDeniedDialog();
    }
  }

  // 권한 거부 시 안내 다이얼로그 표시
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("권한 거부"),
        content: Text("위치 권한이 거부되었습니다. 앱 설정에서 위치 권한을 허용해주세요."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  // 위치 정보와 날씨 데이터를 가져오는 함수
  Future<void> _fetchLocationAndWeatherData() async {
    try {
      // 위치 정보 가져오기
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      // .env에서 API 키를 가져옵니다.
      String apiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY'] ?? '';

      if (apiKey.isEmpty) {
        throw Exception("API 키가 설정되지 않았습니다.");
      }

      // 위치 기반 날씨 정보 가져오기 (OpenWeatherMap 예시)
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric&lang=kr'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          cityName = data['name'];
          temperature = (data['main']['temp'] as num).toDouble();
          weatherDescription = data['weather'][0]['description'];
          windStrength = (data['wind']['speed'] as num).toDouble();
        });

        _showWeatherDialog();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // 바람의 세기를 텍스트로 변환하는 함수
  String getWindStrengthDescription() {
    if (windStrength != null) {
      if (windStrength! >= 5.0) {
        return "강풍";
      } else if (windStrength! >= 2.0) {
        return "약풍";
      } else {
        return "미풍";
      }
    }
    return "정보 없음";
  }

  // 날씨 정보를 표시하는 다이얼로그
  void _showWeatherDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("날씨 정보"),
        content: Text(
          "오늘의 날씨는 $cityName입니다.\n"
              "현재 날씨: $weatherDescription\n"
              "기온: $temperature°C\n"
              "바람의 세기: ${getWindStrengthDescription()}",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (weatherDescription != null && weatherDescription!.contains('구름조금')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RainUI()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AirBlowerGame()),
                );
              }
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("게임 시작 페이지")),
      body: Center(
        child: Text("잠시만 기다려 주세요..."), // 날씨 정보를 가져오는 동안 안내 메시지 표시
      ),
    );
  }
}