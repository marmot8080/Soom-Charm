import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class RainUI extends StatefulWidget {
  @override
  _RainUIState createState() => _RainUIState();
}

class _RainUIState extends State<RainUI> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  double _ballPosition = 0.5; // 공 위치 (0: 아래쪽, 1: 위쪽)
  double _soundThreshold = 50.0; // 바람 불기 감지 임계값
  bool _gameOver = false;
  double _targetPosition = 0.1; // 목표 위치 (화면 위쪽)

  Timer? _gameTimer;
  int _timeLeft = 30; // 30초 타이머 설정

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

          // 목표 위치에 도달하면 게임 성공
          if (_ballPosition <= _targetPosition) {
            _gameOver = true;
            _stopGame("축하합니다! 목표에 도달했습니다!");
          }
        });
      }
    });
  }

  void _startTimer() {
    _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0 && !_gameOver) {
        setState(() {
          _timeLeft--;
        });
      } else if (_timeLeft == 0 && !_gameOver) {
        _stopGame("시간 초과! 게임 오버입니다.");
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
      _timeLeft = 30;
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
              'assets/sky_rain.json',
              fit: BoxFit.fitHeight,
            ),
          ),
          // 목표 지점 표시
          Positioned(
            top: MediaQuery.of(context).size.height * _targetPosition - 20,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Text(
              "🎯 목표 지점",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          // 상단의 텍스트
          // 타이머
          Positioned(
            top: 40,
            right: 16,
            child: Text(
              "남은 시간: $_timeLeft초",
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
          // 바람으로 움직이는 공
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 25,
            top: MediaQuery.of(context).size.height * _ballPosition,
            child: BallWidget(),
          ),
        ],
      ),
    );
  }
}

class BallWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}