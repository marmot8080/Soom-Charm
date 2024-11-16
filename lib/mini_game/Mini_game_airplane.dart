import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:soom_charm/util/breath_analyzer.dart';
import 'package:soom_charm/mini_game/components/mini_game_airplane_compo_.dart';
import 'package:soom_charm/mini_game/components/minigame_airplane_bg.dart';

class Minigame_airplane extends FlameGame {
  late ScrollingBackground background; // 배경 컴포넌트
  late MiniGameAirplane airplane; // 비행기 컴포넌트
  late BreathAnalyzer breathAnalyzer; // 호흡 분석기

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 배경 추가
    background = ScrollingBackground();
    await add(background);

    airplane = MiniGameAirplane(); //비행기 추가

    await add(airplane);

    // 호흡 분석기 초기화
    breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        // 비행기의 위치 업데이트
        if (lowFreqEnergy > 50) {
          airplane.position.y -= 10; // 호흡 강도가 높으면 비행기가 위로 이동
        } else {
          airplane.position.y += 5; // 호흡 강도가 낮으면 비행기가 아래로 이동
        }

        // 바닥 충돌 확인
        if (airplane.position.y >= size.y - airplane.size.y) {
          print('비행기가 추락했습니다.'); // 게임 종료
          stopGame(); // 게임 종료 로직 호출
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

  void stopGame() {
    pauseEngine(); // 게임 멈추기
  }
}
