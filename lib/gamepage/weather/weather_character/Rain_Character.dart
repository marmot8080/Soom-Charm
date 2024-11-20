import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CharacterIntroScreen extends StatelessWidget {
  final String windStrengthDescription; // 바람 세기 변수 추가

  // 생성자에서 바람 세기 전달받기
  const CharacterIntroScreen({
    super.key,
    required this.windStrengthDescription, // 바람 세기 정보를 전달받음
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 애니메이션
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Lottie.asset(
            'assets/weather/weather_rain.json',
            fit: BoxFit.fitHeight,
          ),
        ),
        // 캐릭터와 말풍선
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/weather/character/character_rain.json', width: 200, height: 200),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "안녕하세요! 오늘의 날씨는 비가 옵니다.\n바람은 $windStrengthDescription 으로 평소보다 좀 더 힘쓰셔야 해요!",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}