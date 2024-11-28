import 'package:contact/gamepage/weather/weather_character/Snow_Character.dart';
import 'package:contact/gamepage/weather/GameLogic.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SnowUI extends StatefulWidget {
  final String windStrengthDescription; // 바람 세기 정보 전달
  final String weatherDescription = "눈";

  const SnowUI({super.key, required this.windStrengthDescription});

  @override
  SnowUIState createState() => SnowUIState();
}

class SnowUIState extends State<SnowUI> {
  bool _showGame = false; // 게임 화면 전환 여부

  @override
  void initState() {
    super.initState();
    _showCharacterIntro(); // 캐릭터 소개 후 게임 시작
  }

  void _showCharacterIntro() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showGame = true; // 게임 화면 표시
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showGame
          ? GameLogic(
          windStrengthDescription: widget.windStrengthDescription,
          weatherDescription: widget.weatherDescription
      ) // 게임 화면으로 전환
          : CharacterIntroScreen(windStrengthDescription: widget.windStrengthDescription), // 캐릭터 소개 화면
    );
  }
}