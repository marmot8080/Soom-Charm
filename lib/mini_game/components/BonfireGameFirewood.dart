import 'package:flame/components.dart';

class BonfireGameFirewood extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('firewood.png');

    final spriteOriginalSize = sprite!.srcSize; // 이미지 크기
    final screenSize = gameRef.size; // 화면 크기
    double scaleFactor; // 화면 비율

    if (screenSize.x / spriteOriginalSize.x < screenSize.y / spriteOriginalSize.y) {
      scaleFactor = screenSize.x / spriteOriginalSize.x;  // 가로를 기준으로 스케일링
    } else {
      scaleFactor = screenSize.y / spriteOriginalSize.y;  // 세로를 기준으로 스케일링
    }

    // 원본 비율을 유지하면서 크기 조정
    size = spriteOriginalSize * scaleFactor * 0.5;

    // 중앙 위치 설정
    position = Vector2(screenSize.x * 0.3, screenSize.y * 0.72);
  }
}