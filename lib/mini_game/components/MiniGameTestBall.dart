import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class MiniGameTestBall extends SpriteComponent with HasGameRef, CollisionCallbacks {
  static const double ballSize = 60.0;
  MiniGameTestBall({required position})
  : super(size: Vector2.all(ballSize), position: position);

  void onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('mini_game_test_ball.png');
    position = position;
  }
}