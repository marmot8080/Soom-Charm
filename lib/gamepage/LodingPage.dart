import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'gameui_component/WeatherInfoViewModel.dart';
import 'gameui_component/WeatherService.dart';

class LoadingPage extends StatefulWidget {
  final Function(WeatherInfoViewModel) onLoadingComplete;

  const LoadingPage({required this.onLoadingComplete, super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {
  late double _progress; // 로딩 진행 상태 변수
  final WeatherInfoViewModel weatherInfo = WeatherInfoViewModel(WeatherService());

  @override
  void initState() {
    super.initState();
    _progress = 0.0; // 로딩바 초기값 설정

    // 날씨 정보 가져오기 시작
    _fetchWeatherInfo();
  }

  Future<void> _fetchWeatherInfo() async {
    try {
      final stopwatch = Stopwatch()..start(); // GPS 로딩 시간 측정

      // 날씨 정보 가져오기
      await weatherInfo.fetchWeatherInfo();

      // GPS 로딩 시간이 끝날 때까지 로딩바 업데이트
      while (stopwatch.elapsed < Duration(seconds: 10)) { // 정확한 시간 맞추기 위해 최대 10초 기다림
        setState(() {
          _progress = stopwatch.elapsed.inMilliseconds / 10000.0; // 10초 동안 진행
        });
        await Future.delayed(Duration(milliseconds: 50)); // 50ms마다 진행 상태 업데이트
      }

      // 로딩 애니메이션이 끝난 후 진행 상태 100%로 설정
      setState(() {
        _progress = 1.0;
      });

      widget.onLoadingComplete(weatherInfo); // 로딩 완료 후 콜백 호출
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching weather info: $e");
      }
      // 에러 처리
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFCBE3FA), // 하늘색 배경
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 상단 제목
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '횡경막 호흡법',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // 이미지 설명 부분
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                'assets/Loading_belly_breathing.png',
                width: size.width * 0.7, // 화면 너비의 70%
                height: size.height * 0.5, // 화면 높이의 50%
                fit: BoxFit.contain,
              ),
            ),
            // 하단 설명 텍스트
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '손을 배, 가슴에 올려 가슴은 움직이지 않고\n배가 움직이는 것을 느끼며 호흡해보세요!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // 로딩 바
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                value: _progress, // GPS 로딩 상태에 맞춰 진행 상태 업데이트
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[800]!),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}