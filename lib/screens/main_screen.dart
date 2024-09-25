import 'package:flutter/material.dart';
import 'mini_game/mini_game_test.dart';
import 'package:soom_charm/screens/GPS_tracker_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MiniGameTest()),
                );
              },
              child: Text('Mini Game'),
            ),
            SizedBox(height: 20), // 버튼 간 간격 조정
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GPSTrackerScreen()),
                );
              },
              child: Text('GPS tracker'),
            ),
          ],
        ),
      ),
    );
  }
}
