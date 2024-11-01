import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:soom_charm/mini_game/components/MiniGameTestBg.dart';
import 'package:soom_charm/mini_game/components/MiniGameTestBall.dart';
import 'package:soom_charm/util/BreathAnalyzer.dart';

class MiniGameTest extends FlameGame {
  final MiniGameTestBg _bg = MiniGameTestBg();
  final int _gForce = 400;  // _ball y좌표 값 증감에 대한 고정 감소 값
  late MiniGameTestBall _ball;
  late BreathAnalyzer _breathAnalyzer;
  double _newY = 0.0; // _ball 컴포넌트 위치
  double _lowFreqEnergy = 0.0;
  bool _isDone = false;
  bool _isStarted = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _ball = MiniGameTestBall(
      position: Vector2(size.x / 2 - 30, size.y - 100));

    await add(_bg);
    await add (_ball);

    // BreathAnalyzer 초기화
    _breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        _lowFreqEnergy = lowFreqEnergy;

        // record 라이브러리의 마이크 입력 불안정성으로 인해 _lowFreqEnergy 범위 축소 처리
        if(_lowFreqEnergy > 100) _lowFreqEnergy = 100 + _lowFreqEnergy / 100;

        _lowFreqEnergy *= 8 / ((size.y - _ball.position.y) ~/ 100);
      },
    );

    // 바람 소리 감지를 시작
    _startBreathDetection();
  }

  @override
  void update(double dt) async {
    super.update(dt);

    _newY = _ball.position.y + 2 * (_gForce - _lowFreqEnergy) * dt;

    if(_newY > size.y - 100) {  // 게임 종료 여부 확인
      if(_isStarted) _isDone = true;
      _newY = size.y - 100;
    }
    else if(_newY < size.y - 200 && !_isStarted) _isStarted = true; // 게임 시작 여부 확인
    else if(_newY < size.y - 500) _newY = size.y - 500; // 최대 y값 적용

    // _ball 위치 업데이트
    _ball.position = Vector2(size.x / 2 - 30, _newY);

    if(_isDone) {
      _stopBreathDetection();
    }
  }

  @override
  void onRemove() {
    _stopBreathDetection();

    super.onRemove();
  }

  // 바람 소리 감지 시작
  Future<void> _startBreathDetection() async {
    try {
      await _breathAnalyzer.startListening();
    } catch (e) {
      debugPrint('Error: ${e}');
    }
  }

  void _stopBreathDetection() {
    try {
      _breathAnalyzer.stopListening();
    } catch (e) {
      debugPrint('Error: ${e}');
    }
  }
}