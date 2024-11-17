import 'package:flutter/material.dart';

class WeatherDialog extends StatelessWidget {
  final String cityName;
  final String weatherDescription;
  final double temperature;
  final String windStrengthDescription;

  WeatherDialog({
    required this.cityName,
    required this.weatherDescription,
    required this.temperature,
    required this.windStrengthDescription,
  });

  @override
  Widget build(BuildContext context) {
    // 빈 위젯 반환: 아무것도 표시하지 않음
    return SizedBox.shrink(); // UI 출력 안 함
  }
}