import 'package:flutter/material.dart';
import 'LodingPage.dart';
import 'gameui_component/WeatherNavigationService.dart';

class GameUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      onLoadingComplete: (weatherInfo) {
        // 로딩 완료 후 WeatherNavigationService 호출
        WeatherNavigationService.navigateBasedOnWeather(
          context,
          weatherInfo,
          weatherInfo.getWindStrengthDescription(),
        );
      },
    );
  }
}