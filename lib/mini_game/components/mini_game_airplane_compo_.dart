import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MiniGameAirplane extends SpriteComponent with HasGameRef {
  double velocity = 0.0; // 현재 속도
  final double gravity = 5.0; // 중력 가속도 (픽셀/초^2)
  final double maxAngle = 0.5; // 최대 회전 각도 (라디안) 약 28.65도

  // lerp 함수 정의
  double lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('Airplane.png');

    // 비행기의 크기와 초기 위치 설정
    final spriteOriginalSize = sprite!.srcSize;
    final screenSize = gameRef.size;
    double scaleFactor = screenSize.y / spriteOriginalSize.y * 0.1;

    size = spriteOriginalSize * scaleFactor;
    position = Vector2(screenSize.x / 2 - size.x / 2, screenSize.y / 4);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 중력에 따라 속도 업데이트
    velocity += gravity * dt;
    position.y += velocity * dt;

    // 회전 각도 조정
    if (velocity > 0) {
      // 아래로 내려갈 때
      angle = lerp(angle, maxAngle, 3 * dt); // 오른쪽 아래 대각선 (부드럽게)
    } else {
      // 위로 올라갈 때
      angle = lerp(angle, -maxAngle, 1 * dt); // 오른쪽 위 대각선 (부드럽게)
    }

    // 바닥 충돌 처리
    if (position.y >= gameRef.size.y - size.y) {
      position.y = gameRef.size.y - size.y;
      velocity = 0.0;
    }
  }
}
