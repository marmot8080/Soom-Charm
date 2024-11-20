import 'package:flutter/material.dart';
import 'package:contact/gamepage/weather/weather_component/Cloud_UI.dart';
import 'package:contact/gamepage/weather/weather_component/Sun_UI.dart';
import 'package:contact/gamepage/weather/weather_component/Rain_UI.dart';
import 'package:contact/gamepage/weather/weather_component/Snow_UI.dart';
import 'WeatherInfoViewModel.dart';

class WeatherNavigationService {
  static void navigateBasedOnWeather(BuildContext context, WeatherInfoViewModel weatherInfo, String windStrengthDescription) {
  //static void navigateBasedOnWeather(BuildContext context, WeatherInfoViewModel weatherInfo) {
    // 이걸로 바꿔야함!!

    String? weatherDescription = weatherInfo.weatherDescription?.toLowerCase();

    if (weatherDescription != null) {
      if (weatherDescription.contains('맑음')) {
        // 맑은 날씨일 때 (바람 강도에 맞춰 게임 UI 선택)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SunUI(windStrengthDescription: windStrengthDescription), // windStrength를 전달하지 않음
          ),
        );
      } else if (weatherDescription.contains('구름') || weatherDescription.contains('흐림')) {
        // 구름 또는 흐림 날씨일 때
        Navigator.push(
          context,
          MaterialPageRoute(
            //builder: (context) => CloudUI(), // windStrength를 전달하지 않음
            // 이걸로 바꿔야함!!!!
            builder: (context) => CloudUI(windStrengthDescription: windStrengthDescription), // 바람 세기 정보를 전달
          ),
        );
      } else if (weatherDescription.contains('비')) {
        // 비 오는 날씨일 때
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RainUI(windStrengthDescription: windStrengthDescription), // windStrength를 전달하지 않음
          ),
        );
      } else if (weatherDescription.contains('눈')) {
        // 눈 오는 날씨일 때
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SnowUI(windStrengthDescription: windStrengthDescription), // windStrength를 전달하지 않음
          ),
        );
      }
    }
  }
}