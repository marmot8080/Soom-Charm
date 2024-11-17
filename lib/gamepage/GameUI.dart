import 'package:flutter/material.dart';
import 'gameui_component/WeatherInfoViewModel.dart';
import 'gameui_component/WeatherService.dart';
import 'gameui_component/WeatherNavigationService.dart';

class GameUI extends StatefulWidget {
  @override
  _GameUIState createState() => _GameUIState();
}

class _GameUIState extends State<GameUI> {
  final WeatherInfoViewModel weatherInfo = WeatherInfoViewModel(WeatherService());

  @override
  void initState() {
    super.initState();
    _fetchWeatherInfo();
  }

  Future<void> _fetchWeatherInfo() async {
    try {
      await weatherInfo.fetchWeatherInfo();
      _showWeatherDialog();
    } catch (e) {
      print("Error: $e");
    }
  }

  void _showWeatherDialog() {
    // UI 없이 날씨 데이터를 기반으로 네비게이션만 처리
    WeatherNavigationService.navigateBasedOnWeather(
      context,
      weatherInfo,
      weatherInfo.getWindStrengthDescription(), // 바람 세기 정보 전달
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