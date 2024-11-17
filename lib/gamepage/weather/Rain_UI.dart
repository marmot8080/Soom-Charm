import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class RainUI extends StatefulWidget {
  const RainUI({super.key});

  @override
  _RainUIState createState() => _RainUIState();
}

class _RainUIState extends State<RainUI> {
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
          ? GameScreen() // 게임 화면으로 전환
          : CharacterIntroScreen(), // 캐릭터 소개 화면
    );
  }
}

class CharacterIntroScreen extends StatelessWidget {
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
                  "안녕하세요! 오늘의 날씨는 흐리네요.\n바람은 약풍으로 평소보다 좀더 힘쓰셔야해요!",
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

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  double _balloonSize = 50.0; // 풍선의 초기 크기
  double _soundThreshold = 50.0; // 바람 불기 감지 임계값
  bool _gameOver = false;
  double _maxBalloonSize = 500.0; // 게임 승리를 위한 최대 풍선 크기
  bool _bursting = false; // 풍선 터짐 여부

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
            _balloonSize += 7.0; // 바람을 불 때마다 풍선 크기가 증가
          } else {
            _balloonSize -= 2.0; // 바람이 없으면 풍선이 약간 줄어듦
          }
          _balloonSize = _balloonSize.clamp(50.0, _maxBalloonSize);

          // 최대 크기에 도달하면 풍선 터지는 애니메이션 시작
          if (_balloonSize >= _maxBalloonSize && !_bursting) {
            _bursting = true;
            _showBurstAnimation();
          }
        });
      }
    });
  }

  void _showBurstAnimation() {
    // 풍선 터짐 애니메이션 후 게임 종료
    setState(() {
      _balloonSize = 0; // 풍선을 작아지게 하여 터짐 효과
    });

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

  @override
  Widget build(BuildContext context) {
    double balloonTopPosition = (MediaQuery.of(context).size.height - _balloonSize * 1.5)
        .clamp(0.0, MediaQuery.of(context).size.height - _balloonSize);

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

class BalloonWidget extends StatelessWidget {
  final double size;
  final bool bursting;

  BalloonWidget({required this.size, required this.bursting});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: bursting
          ? Lottie.asset('assets/balloon_exploded.json') // 터지는 애니메이션 경로
          : Lottie.asset('assets/balloon.json'), // 풍선 애니메이션 경로
    );
  }
}