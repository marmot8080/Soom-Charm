import 'package:flutter/material.dart';
import 'mini_game/mini_game_test.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MiniGameTest()),
            );
          },
          child: Text('Go to Mini Game'),
        ),
      ),
    );
  }
}