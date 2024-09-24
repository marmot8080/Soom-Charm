import 'package:flutter/material.dart';
import 'package:soom_charm/util/breath_analyzer.dart';

class MiniGameTest extends StatefulWidget {
  @override
  _MiniGameTestState createState() => _MiniGameTestState();
}

class _MiniGameTestState extends State<MiniGameTest> {
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
          _statusMessage = lowFreqEnergy > 10
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
        title: Text('바람 소리 감지 테스트'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _statusMessage,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              '저주파 에너지: ${_lowFreqEnergy.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _statusMessage = "바람 소리 감지 재시작 중...";
                });
                _startBreathDetection();  // 감지 재시작
              },
              child: Text("감지 재시작"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _breathAnalyzer.stopListening();
                setState(() {
                  _statusMessage = "바람 소리 감지 중지됨";
                });
              },
              child: Text("감지 중지"),
            ),
          ],
        ),
      ),
    );
  }
}
