import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:soom_charm/mini_game/BonfireGame.dart';

class BonfireGamePage extends StatefulWidget {
  @override
  _BonfireGamePage createState() => _BonfireGamePage();
}

class _BonfireGamePage extends State<BonfireGamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(padding: const EdgeInsets.all(8.0),
          child: GameWidget(
              game: BonfireGame()
          ),
        ),
      ),
    );
  }
}
