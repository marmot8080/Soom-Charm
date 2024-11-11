import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class SunUI extends StatefulWidget {
  @override
  _SunnUIState createState() => _SunnUIState();
}

class _SunnUIState extends State<SunUI> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  double _ballPosition = 0.5; // 공 위치 (0: 아래쪽, 1: 위쪽)
  double _soundThreshold = 50.0; // 바람 불기 감지 임계값
  bool _gameOver = false;
  double _bottomThreshold = 0.9; // 게임 종료를 위한 바닥 임계값

  Timer? _gameTimer;
  int _elapsedTime = 0; // 경과 시간 기록

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _startTimer();
  }

  Future<void> _initializeRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw '마이크 권한이 필요합니다';
    }

    await _recorder.openRecorder();
    _recorder.setSubscriptionDuration(Duration(milliseconds: 100));

    await _recorder.startRecorder(toFile: 'dummy.aac');
    _recorder.onProgress!.listen((event) {
      double? decibels = event.decibels;

      if (decibels != null && !_gameOver) {
        setState(() {
          if (decibels > _soundThreshold) {
            _ballPosition -= 0.02; // 공이 올라감
          } else {
            _ballPosition += 0.02; // 공이 내려감
          }
          _ballPosition = _ballPosition.clamp(0.0, 1.0); // 화면 범위 내로 위치 제한

          // 바닥에 도달하면 게임 실패
          if (_ballPosition >= _bottomThreshold) {
            _gameOver = true;
            _stopGame("게임 종료! 공이 바닥에 도달했습니다. 경과 시간: $_elapsedTime초");
          }
        });
      }
    });
  }

  void _startTimer() {
    _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_gameOver) {
        setState(() {
          _elapsedTime++;
        });
      }
    });
  }

  void _stopGame(String message) {
    _recorder.closeRecorder();
    _gameTimer?.cancel();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("게임 종료"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Text("다시 시작"),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _ballPosition = 0.5;
      _gameOver = false;
      _elapsedTime = 0;
    });
    _initializeRecorder();
    _startTimer();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 비 애니메이션 배경
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Lottie.asset(
              'assets/weather/weather_rain.json',
              fit: BoxFit.fitHeight,
            ),
          ),
          // 상단의 텍스트
          Positioned(
            top: 40,
            right: 16,
            child: Text(
              "경과 시간: $_elapsedTime초",
              style: TextStyle(color: Colors.redAccent, fontSize: 18),
            ),
          ),
          // 중앙의 텍스트
          Center(
            child: Text(
              "배경화면은 비입니다. 마이크에 바람을 불어 공을 위로 움직이세요!",
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          // 위치에 따라 다른 Lottie 애니메이션을 보여주는 공
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 25,
            top: MediaQuery.of(context).size.height * _ballPosition,
            child: BallWidget(position: _ballPosition),
          ),
        ],
      ),
    );
  }
}

class BallWidget extends StatelessWidget {
  final double position;

  BallWidget({required this.position});

  @override
  Widget build(BuildContext context) {
    String animationPath;

    // 위치에 따라 다른 애니메이션 경로를 선택
    if (position <= 0.3) {
      animationPath = 'assets/weather/common_lungs_image/lungs_first.json';
    } else if (position >= 0.7) {
      animationPath = 'assets/weather/common_lungs_image/lungs_middle.json';
    } else {
      animationPath = 'assets/weather/common_lungs_image/lungs_final.json';
    }

    return SizedBox(
      width: 50,
      height: 50,
      child: Lottie.asset(animationPath),
    );
  }
}