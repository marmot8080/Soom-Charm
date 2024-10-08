import 'package:flutter/material.dart';
import 'package:soom_charm/screens/GPS_tracker_screen.dart';
import 'package:soom_charm/screens/game_stage_screen.dart';
import 'package:soom_charm/screens/mini_game/mini_game_screen_test.dart';
import 'package:soom_charm/screens/mini_game/recorderGamePage.dart';
import 'package:soom_charm/screens/storePage.dart';
import 'package:soom_charm/screens/settingsPage.dart';
import 'mainPage.dart';
import 'loadingPage.dart';

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
                  MaterialPageRoute(
                      builder: (context) => GameStageScreen()),
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
            SizedBox(height: 20), // 버튼 간 간격 조정
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Text('mainPage'),
            ),
            SizedBox(height: 20), // 버튼 간 간격 조정
          ElevatedButton(
            // MainPage에서 버튼 클릭 시 페이지 이동
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loadingPage()),
              );
            },
            child: Text('loadingPage'),
          ),
          SizedBox(height: 20), // 버튼 간 간격 조정
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => settingsPage()),
              );
            },
            child: Text('settingsPage'),
          ),
          SizedBox(height: 20), // 버튼 간 간격 조정
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => storePage()),
              );
            },
            child: Text('storePage'),
          ),
          SizedBox(height: 20), // 버튼 간 간격 조정
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => recorderGamePage()),
                );
              },
              child: Text('RecorderGame'),
            ),
        ],
      ),
      ),
    );
  }
}
