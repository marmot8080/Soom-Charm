import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AirBlowerGame extends StatefulWidget {
  @override
  _AirBlowerGameState createState() => _AirBlowerGameState();
}

class _AirBlowerGameState extends State<AirBlowerGame> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  double _ballPosition = 0.5; // 공 위치 (0: 아래쪽, 1: 위쪽)
  double _soundThreshold = 50.0; // 바람 불기 감지 임계값

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
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

      if (decibels != null) {
        setState(() {
          // 임계값을 넘으면 공이 올라가고, 그렇지 않으면 공이 아래로 내려옴
          if (decibels > _soundThreshold) {
            _ballPosition -= 0.02; // 공이 올라감
          } else {
            _ballPosition += 0.02; // 공이 내려감
          }
          _ballPosition = _ballPosition.clamp(0.0, 1.0); // 화면 범위 내로 위치 제한
        });
      }
    });
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Air Blower Game')),
      body: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 25,
            top: MediaQuery.of(context).size.height * _ballPosition,
            child: BallWidget(),
          ),
          Center(
            child: Text(
              '마이크에 바람을 불어 공을 위로 움직이세요!',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
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