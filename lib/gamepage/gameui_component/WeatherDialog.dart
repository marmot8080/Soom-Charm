import 'package:flutter/material.dart';

class WeatherDialog extends StatelessWidget {
  final String cityName;
  final String weatherDescription;
  final double temperature;
  final String windStrengthDescription;
  final VoidCallback onConfirm;

  WeatherDialog({
    required this.cityName,
    required this.weatherDescription,
    required this.temperature,
    required this.windStrengthDescription,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("날씨 정보"),
      content: Text(
        "오늘의 날씨는 $cityName입니다.\n"
            "현재 날씨: $weatherDescription\n"
            "기온: $temperature°C\n"
            "바람의 세기: $windStrengthDescription",
      ),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: Text("확인"),
        ),
      ],
    );
  }
}