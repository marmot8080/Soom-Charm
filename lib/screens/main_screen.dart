import 'package:flutter/material.dart';
import 'package:soom_charm/screens/GPS_tracker_screen.dart';
import 'package:soom_charm/screens/game_stage_screen.dart';
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
                child: Text('GPS tracker'),),
              SizedBox(height: 20), // 버튼 간 간격 조정
              ElevatedButton(
                // MainPage에서 버튼 클릭 시 페이지 이동
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage()), // MainPageSecond로 이동
                  );
                },

                child: Text('MainPage'),
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
            ]
        ),
      ),
    );
  }

}