import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../../mini_game/RecorderGame.dart';

class RecorderGamePage extends StatelessWidget {
  const RecorderGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCBE3FA), // 배경색 설정
      body: Center(
        child: GameWidget(
          game: RecorderGame(),
        ),
      ),
    );
  }
}
