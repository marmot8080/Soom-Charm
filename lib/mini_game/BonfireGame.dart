import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:soom_charm/util/BreathAnalyzer.dart';
import 'package:soom_charm/mini_game/components/BonfireGameFirewood.dart';
import 'package:soom_charm/mini_game/components/BonfireGameBg.dart';

class BonfireGame extends FlameGame {
  late BreathAnalyzer _breathAnalyzer;
  late BonfireGameFirewood _firewood = BonfireGameFirewood();
  late BonfireGameBg _bg = BonfireGameBg();
  late SpriteAnimationComponent _fire;
  double _lowFreqEnergy = 0.0;
  double _fireSize = 32;
  final double _maxFireSize = 256;
  double _time = 0.0;
  double _tmp = 0.0;
  final int _resistanceValue = 200;
  bool _isStarted = false;
  bool _isDone = false;

  late TextComponent _tmpText;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 스프라이트 시트 로드
    final fireImage = await Flame.images.load('fire_sprite_sheet.png');
    // 스프라이트 시트의 각 프레임 크기 지정
    final spriteSheet = SpriteSheet(image: fireImage, srcSize: Vector2(1342, 1396));
    // 스프라이트 애니메이션 생성
    final fireAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 9);

    // SpriteAnimationComponent 추가
    _fire = SpriteAnimationComponent(
      animation: fireAnimation,
      size: Vector2.all(_fireSize),
      position: Vector2(size.x/2 - _fireSize/2, size.y/2 - _fireSize)
    );

    // BreathAnalyzer 초기화
    _breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        _lowFreqEnergy = lowFreqEnergy;
        if(_lowFreqEnergy > 100) _lowFreqEnergy = 100 + _lowFreqEnergy / 100;
        _lowFreqEnergy *= 4;
      },
    );

    await add(_bg);
    await add(_firewood);
    await add(_fire);

    /*
    // _tmp 값 확인용
    _tmpText = TextComponent(
      text: '_tmp: $_tmp',
      position: Vector2(size.x/2 - 25, size.y/2 + 100),
      textRenderer: TextPaint(style: const TextStyle(color: CupertinoColors.black)),
    );
    await add(_tmpText);
    */

    // 바람 소리 감지를 시작
    _startBreathDetection();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _time += dt;
    
    // 10초마다 조건 확인 후 모닥불 크기 업데이트
    if(_time ~/ 10 > 0 && _fireSize < _maxFireSize && _isStarted && !_isDone) {
      _time %= 10;
      _fireSize += 32;
      _fire.size = Vector2.all(_fireSize);
      _fire.position = Vector2(size.x/2 - _fireSize/2, size.y/2 - _fireSize);
    }

    _tmp += 2 * (_lowFreqEnergy - _resistanceValue) * dt;
    if(_tmp < 0) _tmp = 0;
    if(_tmp > 600) _tmp = 600;
    
    // _tmpText 값 업데이트
    // _tmpText.text = '_tmp: $_tmp';

    if(!_isStarted && _tmp > 100) _isStarted = true;
    else if(_isStarted && _tmp < 10 && !_isDone) {
      _isDone = true;
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

  // 바람 소리 감지 종료
  Future<void> _stopBreathDetection() async {
    try {
      await _breathAnalyzer.stopListening();
    } catch (e) {
      debugPrint('Error: ${e}');
    }
  }
}