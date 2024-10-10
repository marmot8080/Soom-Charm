import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:soom_charm/mini_game/components/MiniGameTestBg.dart';
import 'package:soom_charm/mini_game/components/MiniGameTestBall.dart';
import 'package:soom_charm/util/BreathAnalyzer.dart';

class MiniGameTest extends FlameGame {
  final MiniGameTestBg _bg = MiniGameTestBg();
  late MiniGameTestBall _ball;
  late BreathAnalyzer _breathAnalyzer;
  double newY = 0.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await add(_bg);
    _ball = MiniGameTestBall(
      position: Vector2(size.x / 2 - 30, size.y - 100));
    await add (_ball);

    // BreathAnalyzer 초기화
    _breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        newY = size.y - 100 - ((lowFreqEnergy / 10) - 50);
        if (newY >= size.y - 100) newY = size.y - 100;
        else if (newY < 0) newY = 0;
      },
    );

    // 바람 소리 감지를 시작
    _startBreathDetection();
  }

  @override
  void update(double dt) async {
    super.update(dt);

    _ball.position = Vector2(_ball.position.x, newY);
  }

  @override
  void onRemove() {
    _breathAnalyzer.stopListening();

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
}