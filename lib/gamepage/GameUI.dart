import 'package:flutter/material.dart';
import 'gameui_component/WeatherDialog.dart';
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

  // void _showWeatherDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => WeatherDialog(
  //       cityName: weatherInfo.cityName ?? "알 수 없음",
  //       weatherDescription: weatherInfo.weatherDescription ?? "알 수 없음",
  //       temperature: weatherInfo.temperature ?? 0.0,
  //       windStrengthDescription: weatherInfo.getWindStrengthDescription(),
  //       onConfirm: () {
  //         Navigator.pop(context);
  //         WeatherNavigationService.navigateBasedOnWeather(context, weatherInfo);
  //       },
  //     ),
  //   );
  // }
  // 이걸로 바꿔야함!!!!!!!!


  void _showWeatherDialog() {
    showDialog(
      context: context,
      builder: (context) => WeatherDialog(
        cityName: weatherInfo.cityName ?? "알 수 없음",
        weatherDescription: weatherInfo.weatherDescription ?? "알 수 없음",
        temperature: weatherInfo.temperature ?? 0.0,
        windStrengthDescription: weatherInfo.getWindStrengthDescription(),
        onConfirm: () {
          Navigator.pop(context);
          WeatherNavigationService.navigateBasedOnWeather(
              context,
              weatherInfo,
              weatherInfo.getWindStrengthDescription() // 바람 세기 정보 전달
          );
        },
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