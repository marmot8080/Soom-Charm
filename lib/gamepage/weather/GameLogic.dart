import 'package:contact/gamepage/weather/BalloonLogic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class GameLogic extends StatefulWidget {
  final String windStrengthDescription; // 바람 세기 정보 전달
  final String weatherDescription;

  const GameLogic({super.key, required this.windStrengthDescription, required this.weatherDescription});

  @override
  GameLogicState createState() => GameLogicState();
}

class GameLogicState extends State<GameLogic> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  double _balloonSize = 50.0; // 풍선의 초기 크기
  final double _soundThreshold = 50.0; // 바람 불기 감지 임계값
  bool _gameOver = false;
  final double _maxBalloonSize = 500.0; // 게임 승리를 위한 최대 풍선 크기
  bool _bursting = false; // 풍선 터짐 여부
  double _balloonGrowthRate = 7.0; // 풍선 크기 증가율 (바람 세기에 따라 달라짐)

  Timer? _gameTimer;
  int _elapsedTime = 0; // 경과 시간 기록

  @override
  void initState() {
    super.initState();
    _adjustGrowthRateBasedOnWindStrength(); // 가장 먼저 실행되도록 수정
    _initializeRecorder().then((_) {
      _startTimer(); // 초기화가 완료된 후 타이머 시작
    });
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
            _balloonSize += _balloonGrowthRate; // 바람을 불 때마다 풍선 크기가 증가
          } else {
            _balloonSize -= 2.0; // 바람이 없으면 풍선이 약간 줄어듦
          }
          _balloonSize = _balloonSize.clamp(50.0, _maxBalloonSize);

          // 최대 크기에 도달하면 풍선 터짐 상태로 변경
          if (_balloonSize >= _maxBalloonSize && !_bursting) {
            _bursting = true;
            _handleBurst();
          }
        });
      }
    });
  }

  void _adjustGrowthRateBasedOnWindStrength() {
    // windStrengthDescription에 따라 풍선의 성장 속도 조정
    if (kDebugMode) {
      print("현재 바람 세기: ${widget.windStrengthDescription}");
    }
    switch (widget.windStrengthDescription) {
      case '강풍':
        _balloonGrowthRate = 10.0; // 강풍일 경우 성장 속도 증가
        break;
      case '약풍':
        _balloonGrowthRate = 7.0; // 약풍일 경우 기본 성장 속도
        break;
      case '미풍':
        _balloonGrowthRate = 5.0; // 미풍일 경우 성장 속도 감소
        break;
      default:
        _balloonGrowthRate = 7.0; // 기본값
    }
    if (kDebugMode) {
      print("풍선 성장 속도: $_balloonGrowthRate");
    }
  }

  void _handleBurst() {
    // 터짐 상태 후 1초 뒤 게임 종료
    Future.delayed(Duration(seconds: 1), () {
      _stopGame("축하합니다! 풍선이 터졌습니다. 경과 시간: $_elapsedTime초");
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
    _gameOver = true;
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
      _balloonSize = 50.0;
      _gameOver = false;
      _elapsedTime = 0;
      _bursting = false;
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

  // 날씨 조건에 따라 Lottie 파일 경로 선택
  String _getLottieFilePath() {
    // if (kDebugMode) {
    //   print(widget.weatherDescription);
    // }
    switch (widget.weatherDescription) {
      case '맑음':
        return 'assets/weather/weather_sun.json'; // 맑음
      case '눈':
        return 'assets/weather/weather_snow.json'; // 눈
      case '비':
        return 'assets/weather/weather_rain.json'; // 비
      case '흐림':
        return 'assets/weather/weather_cloud.json'; // 구름
      default:
        return '0'; // 기본값
    }
  }

  @override
  Widget build(BuildContext context) {
    double balloonTopPosition = (MediaQuery.of(context).size.height - _balloonSize * 1.5)
        .clamp(0.0, MediaQuery.of(context).size.height - _balloonSize);

    return Stack(
      children: [
        // 배경 애니메이션 (조건에 따른 파일 사용)
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Lottie.asset(
            _getLottieFilePath(), // 조건에 따라 파일 선택
            fit: BoxFit.fitHeight,
          ),
        ),
        // 상단의 경과 시간 텍스트
        Positioned(
          top: 40,
          right: 16,
          child: Text(
            "경과 시간: $_elapsedTime초",
            style: TextStyle(color: Colors.redAccent, fontSize: 18),
          ),
        ),
        // 중앙의 안내 텍스트
        Center(
          child: Text(
            "마이크에 바람을 불어 풍선을 부풀리세요!",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        // 풍선 애니메이션
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - _balloonSize / 2,
          top: balloonTopPosition,
          child: BalloonWidget(size: _balloonSize, bursting: _bursting),
        ),
      ],
    );
  }
}
