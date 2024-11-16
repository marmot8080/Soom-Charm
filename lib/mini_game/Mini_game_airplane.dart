import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:soom_charm/util/breath_analyzer.dart';
import 'package:soom_charm/mini_game/components/mini_game_airplane_compo_.dart';
import 'package:soom_charm/mini_game/components/minigame_airplane_bg.dart';

class Minigame_airplane extends FlameGame {
  late ScrollingBackground background; // 배경 컴포넌트
  late MiniGameAirplane airplane; // 비행기 컴포넌트
  late BreathAnalyzer breathAnalyzer; // 호흡 분석기

  late double startTime; // 비행 시작 시간
  late double endTime; // 비행 종료 시간
  late TextComponent message; // 메시지 표시용 컴포넌트

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 배경 추가
    background = ScrollingBackground();
    await add(background);

    // 메시지 컴포넌트 추가
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

    // 비행기 추가
    airplane = MiniGameAirplane();
    await add(airplane);

    // 시작 시간 기록
    startTime = DateTime.now().millisecondsSinceEpoch / 1000;

    // 호흡 분석기 초기화
    breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        if (lowFreqEnergy > 50) {
          airplane.position.y -= 10; // 호흡 강도가 높으면 비행기가 위로 이동
        } else {
          airplane.position.y += 5; // 호흡 강도가 낮으면 비행기가 아래로 이동
        }

        // 바닥 충돌 확인
        if (airplane.position.y >= size.y - airplane.size.y) {
          endTime = DateTime.now().millisecondsSinceEpoch / 1000;
          double duration = endTime - startTime;
          _showEndMessage(duration);
          background.stopScrolling();
          stopGame();
        }
      },
    );

    // 마이크 입력 시작
    await breathAnalyzer.startListening();
  }

  @override
  void onRemove() {
    // 게임 종료 시 마이크 입력 중지
    breathAnalyzer.stopListening();
    super.onRemove();
  }

  void _showEndMessage(double duration) {
    // 종료 메시지 설정
    message.text = '비행기가 ${duration.toStringAsFixed(2)}초 동안 날았습니다!';
    message.position = Vector2(size.x / 2, size.y / 2); // 화면 중앙에 표시
  }

  void stopGame() {
    pauseEngine(); // 게임 멈추기
    print('게임 종료');
  }

  void update(double dt) {
    super.update(dt);

    // 중력 적용
    airplane.velocity += airplane.gravity * dt; // 중력에 따른 속도 증가
    airplane.position.y += airplane.velocity * dt; // 속도에 따라 위치 변경

    // 바닥 충돌 처리
    if (airplane.position.y >= size.y - airplane.size.y) {
      airplane.position.y = size.y - airplane.size.y; // 바닥에 고정
      airplane.velocity = 0.0; // 속도 초기화
    }
  }
}
