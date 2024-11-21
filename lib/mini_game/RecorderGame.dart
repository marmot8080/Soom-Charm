import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import '../util/BreathAnalyzer.dart'; // BreathAnalyzer가 필요합니다.

class RecorderGame extends FlameGame {
  late SpriteComponent recorder; // 리코더 이미지
  late TextComponent message;
  late BreathAnalyzer breathAnalyzer;

  bool isBreathing = false; // 바람 감지 상태 추적
  TextComponent? breathIcon; // 바람 이모지
  TextComponent? noteIcon; // 음표 및 물결 표시 이모지
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Color backgroundColor() => const Color(0xFFCBE3FA); // 배경색 설정

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 리코더 이미지 로드 및 초기 위치 설정
    recorder = SpriteComponent()
      ..sprite = await loadSprite('recorder.png') // 'assets/images/recorder.png'
      ..size = Vector2(200, 500) // 리코더 크기
      ..position = Vector2(size.x / 2 - 100, size.y / 2 - 200); // 화면 중앙 배치

    await add(recorder);

    // 메시지 설정
    message = TextComponent(
      text: '리코더를 후후 불어봐!',
      position: Vector2(size.x / 2, size.y * 0.1),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
    await add(message);

    // BreathAnalyzer 설정
    breathAnalyzer = BreathAnalyzer(
      onEnergyDetected: (lowFreqEnergy) {
        if (lowFreqEnergy > 50) {
          if (!isBreathing) {
            isBreathing = true;
            _startBreathIcon(); // 바람 아이콘 렌더링 시작
            _startNoteIcon(); // 음표 및 물결 렌더링 시작
            _startRecorderSound();
          }
        } else {
          if (isBreathing) {
            isBreathing = false;
            _stopBreathIcon(); // 바람 아이콘 제거
            _stopNoteIcon(); // 음표 및 물결 제거
            _stopRecorderSound();
          }
        }
      },
    );

    await breathAnalyzer.startListening();
  }

  void _startBreathIcon() {
    // 바람 이모지가 이미 있으면 추가하지 않음
    if (breathIcon != null) return;

    breathIcon = TextComponent(
      text: '💨', // 바람 이모지
      position: Vector2(size.x / 2, recorder.position.y + recorder.size.y + 65), // 리코더 아래 위치
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 60,
          color: Colors.blueGrey,
        ),
      ),
    );

    breathIcon!.angle = -1.5708;
    add(breathIcon!);
  }

  void _stopBreathIcon() {
    // 바람 이모지 제거
    if (breathIcon != null) {
      remove(breathIcon!);
      breathIcon = null;
    }
  }

  void _startNoteIcon() {
    // 음표 및 물결 표시가 이미 있으면 추가하지 않음
    if (noteIcon != null) return;

    noteIcon = TextComponent(
      text: '🎵 ~~~', // 음표와 물결 표시
      position: Vector2(size.x / 2, recorder.position.y - 60), // 리코더 위 위치
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 60,
          color: Colors.black, // 검정색
        ),
      ),
    );
    add(noteIcon!);
  }

  void _stopNoteIcon() {
    // 음표 및 물결 표시 제거
    if (noteIcon != null) {
      remove(noteIcon!);
      noteIcon = null;
    }
  }

  void _startRecorderSound() async {
    // 리코더 소리를 무한 반복으로 재생
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('sounds/recorder.mp3')); // 소리 파일 경로
  }

  void _stopRecorderSound() async {
    // 리코더 소리 정지
    await _audioPlayer.stop();
  }

  @override
  void onRemove() {
    breathAnalyzer.stopListening();
    _audioPlayer.dispose();
    super.onRemove();
  }
}
