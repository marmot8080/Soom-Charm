import 'package:flutter/material.dart';
import 'package:soom_charm/util/BreathAnalyzer.dart';

class Breathanalyzerpage extends StatefulWidget {
  @override
  _Breathanalyzerpage createState() => _Breathanalyzerpage();
}

class _Breathanalyzerpage extends State<Breathanalyzerpage> {
  BreathAnalyzer? _breathAnalyzer;
  double _lowFreqEnergy = 0.0; // 실시간으로 표시할 저주파 에너지 합계

  @override
  void initState() {
    super.initState();
    _initializeBreathAnalyzer();
  }

  @override
  void dispose() {
    _breathAnalyzer?.stopListening(); // 페이지 종료 시 녹음 중지
    super.dispose();
  }

  void _initializeBreathAnalyzer() {
    // BreathAnalyzer 초기화 및 콜백 설정
    _breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        setState(() {
          _lowFreqEnergy = lowFreqEnergy;
        });
      },
    );

    // 녹음 시작
    _startBreathDetection();
  }

  void _startBreathDetection() async {
    try {
      await _breathAnalyzer?.startListening();
    } catch (e) {
      debugPrint("Error breath detection: $e");
    }
  }

  void _stopBreathDetection() async  {
    try {
      await _breathAnalyzer?.stopListening();
    } catch (e) {
      debugPrint("Error breath detection: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breath Analyzer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Low Frequency Magnitude Sum:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _lowFreqEnergy.toStringAsFixed(2), // 저주파 크기 합계를 소수점 2자리까지 표시
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                // 녹음을 중지하는 버튼
                _stopBreathDetection();
              },
              child: Text('Stop Recording'),
            ),
          ],
        ),
      ),
    );
  }
}
