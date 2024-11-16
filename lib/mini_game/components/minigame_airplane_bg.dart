import 'package:flame/components.dart';
import 'package:flame/game.dart';

class ScrollingBackgroundGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    // 배경 컴포넌트 추가
    await add(ScrollingBackground());
  }
}

class ScrollingBackground extends Component with HasGameRef {
  late SpriteComponent background1;
  late SpriteComponent background2;

  bool isScrollingEnabled = true;

  final double speed = 80; // 배경이 왼쪽으로 움직이는 속도 (픽셀/초)

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 배경 스프라이트 로드
    final backgroundSprite =
        await gameRef.loadSprite('airplane_minigame_backround.png');

    double scaleY = gameRef.size.y / backgroundSprite.srcSize.y;
    // 배경 1
    background1 = SpriteComponent()..sprite = backgroundSprite;
    background1.size = Vector2(backgroundSprite.srcSize.x * scaleY,
        gameRef.size.y); // 화면 크기에 맞게 배경 크기 설정
    background1.position = Vector2(0, 0); // 화면의 왼쪽에 위치

    // 배경 2
    background2 = SpriteComponent()
      ..sprite = backgroundSprite
      ..size = Vector2(backgroundSprite.srcSize.x * scaleY, gameRef.size.y)
      ..position = Vector2(gameRef.size.x, 0); // 화면 오른쪽에 위치 (첫 번째 배경의 끝에서 시작)

    // 배경 컴포넌트 추가
    await add(background1);
    await add(background2);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isScrollingEnabled) {
      // 배경 이동
      background1.position.x -= speed * dt;
      background2.position.x -= speed * dt;

      // 배경이 화면 왼쪽 끝을 지나면 위치 재설정
      if (background1.position.x + background1.size.x < 0) {
        background1.position.x = background2.position.x + background2.size.x;
      }
      if (background2.position.x + background2.size.x < 0) {
        background2.position.x = background1.position.x + background1.size.x;
      }
    }
  }

  void stopScrolling() {
    isScrollingEnabled = false;
  } // 게임이 끝나게되면 화면의 스크롤링이 멈춤
}
