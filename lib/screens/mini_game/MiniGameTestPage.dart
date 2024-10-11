import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:soom_charm/mini_game/MiniGameTest.dart';

class MiniGameTestPage extends StatefulWidget {
  @override
  _MiniGameTestPage createState() => _MiniGameTestPage();
}

class _MiniGameTestPage extends State<MiniGameTestPage> {
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
