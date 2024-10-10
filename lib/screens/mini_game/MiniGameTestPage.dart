import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:soom_charm/mini_game/MiniGameTest.dart';

class MiniGameScreenTest extends StatefulWidget {
  @override
  _MiniGameScreenTestState createState() => _MiniGameScreenTestState();
}

class _MiniGameScreenTestState extends State<MiniGameScreenTest> {
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
      appBar: AppBar(
        title: Text("mini game test"),
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(8.0),
          child: GameWidget(
            game: MiniGameTest()
          ),
        ),
      ),
    );
  }
}
