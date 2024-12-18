import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:soom_charm/mini_game/AirplaneGame.dart';

class AirplaneGamePage extends StatefulWidget {
  @override
  _AirplaneGamePage createState() => _AirplaneGamePage();
}

class _AirplaneGamePage extends State<AirplaneGamePage> {
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
              game: AirplaneGame()
          ),
        ),
      ),
    );
  }
}
