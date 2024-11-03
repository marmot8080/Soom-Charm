import 'package:flame/components.dart';

class BonfireGameBg extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('mini_game_test_bg.png');
    size = Vector2(gameRef.size.x, gameRef.size.y);
    position = Vector2.zero();
  }
}