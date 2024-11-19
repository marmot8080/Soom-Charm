import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:soom_charm/util/BreathAnalyzer.dart';
import 'package:soom_charm/mini_game/components/mini_game_airplane_compo_.dart';
import 'package:soom_charm/mini_game/components/minigame_airplane_bg.dart';

class Minigame_airplane extends FlameGame {
  late ScrollingBackground background;
  late MiniGameAirplane airplane;
  late BreathAnalyzer breathAnalyzer;

  late double startTime;
  late double endTime;
  late TextComponent message;

  bool isGameOver = false; // 게임 종료 상태 플래그

  @override
  Future<void> onLoad() async {
    super.onLoad();

    background = ScrollingBackground();
    await add(background);

    message = TextComponent(
      text: '바람을 불어 비행기를 멀리 날려봐!',
      position: Vector2(size.x / 2, size.y * 0.1),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
    await add(message);

    airplane = MiniGameAirplane();
    await add(airplane);

    startTime = DateTime.now().millisecondsSinceEpoch / 1000;

    breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        if (lowFreqEnergy > 50) {
          airplane.position.y -= 10;
        } else {
          airplane.position.y += 5;
        }

        if (!isGameOver && airplane.position.y >= size.y - airplane.size.y) {
          _triggerGameOver();
        }
      },
    );

    await breathAnalyzer.startListening();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isGameOver) return; // 게임 종료 시 업데이트 멈춤

    airplane.velocity += airplane.gravity * dt;
    airplane.position.y += airplane.velocity * dt;

    if (airplane.position.y >= size.y - airplane.size.y) {
      airplane.position.y = size.y - airplane.size.y;
      airplane.velocity = 0.0;

      if (!isGameOver) {
        _triggerGameOver();
      }
    }
  }

  void _triggerGameOver() {
    isGameOver = true;
    endTime = DateTime.now().millisecondsSinceEpoch / 1000;
    double duration = endTime - startTime;

    background.stopScrolling();
    _showEndMessage(duration);
    stopGame();
  }

  void _showEndMessage(double duration) {
    message.text = '비행기가 ${duration.toStringAsFixed(2)}초 동안 날았습니다!';
    message.position = Vector2(size.x / 2, size.y / 2);
  }

  void stopGame() {
    pauseEngine();
    print('게임 종료');
  }

  @override
  void onRemove() {
    breathAnalyzer.stopListening();
    super.onRemove();
  }
}
