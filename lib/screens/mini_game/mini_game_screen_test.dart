import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:soom_charm/util/breath_analyzer.dart';
import 'package:soom_charm/mini_game/mini_game_test.dart';

class MiniGameScreenTest extends StatefulWidget {
  @override
  _MiniGameScreenTestState createState() => _MiniGameScreenTestState();
}

class _MiniGameScreenTestState extends State<MiniGameScreenTest> {
  late BreathAnalyzer _breathAnalyzer;
  double _lowFreqEnergy = 0.0;
  String _statusMessage = "바람 소리 감지 대기 중...";

  @override
  void initState() {
    super.initState();

    // BreathAnalyzer 초기화
    _breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        setState(() {
          _lowFreqEnergy = lowFreqEnergy;
          _statusMessage = lowFreqEnergy > 500
              ? "바람 소리 감지됨!"
              : "바람 소리 없음";
        });
      },
    );

    // 바람 소리 감지를 시작
    _startBreathDetection();
  }

  @override
  void dispose() {
    _breathAnalyzer.stopListening();
    super.dispose();
  }

  // 바람 소리 감지 시작
  Future<void> _startBreathDetection() async {
    try {
      await _breathAnalyzer.startListening();
    } catch (e) {
      setState(() {
        _statusMessage = "오류 발생: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mini game test"),
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(8.0),
          child: GameWidget(game: MiniGameTest(),
          ),
        ),
      ),
    );
  }
}
