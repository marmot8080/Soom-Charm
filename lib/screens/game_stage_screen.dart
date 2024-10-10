import 'package:flutter/material.dart';
import 'package:soom_charm/screens/GPS_tracker_screen.dart';
import 'package:soom_charm/screens/mini_game/mini_game_screen_test.dart';
import 'package:soom_charm/widgets/game_stage_button.dart';

class GameStageScreen extends StatefulWidget {
  @override
  _GameStageScreen createState() => _GameStageScreen();
}

class _GameStageScreen extends State<GameStageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 상단 심장 아이콘과 타이틀 부분
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.black, size: 40)
                  ),
                  // 하트 아이콘들과 + 아이콘을 감싸는 컨테이너
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFCBE3FA), // 하늘색 배경
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.favorite,
                            color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
                        Icon(Icons.favorite,
                            color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
                        Icon(Icons.favorite,
                            color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
                        SizedBox(width: 4),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GPSTrackerScreen()), // 차후 상점 페이지 이동으로 변경
                              );
                            },
                            icon: Icon(Icons.add, color: Colors.black, size: 30)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  GameStageButton(
                      imagePath: "assets/images/lungs.png",
                      targetPage: MiniGameScreenTest(),
                  ),
                  GameStageButton(
                    imagePath: "assets/images/lungs.png",
                    targetPage: MiniGameScreenTest(),
                  ),
                  GameStageButton(
                    imagePath: "assets/images/lungs.png",
                    targetPage: MiniGameScreenTest(),
                  ),
                ],
              )
            ),
            // 하단 네비게이션 아이콘들
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GPSTrackerScreen()), // 차후 세팅 페이지 이동으로 변경
                        );
                      },
                      icon: Icon(Icons.settings, color: Colors.black, size: 40)
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GPSTrackerScreen()), // 차후 상점 페이지 이동으로 변경
                        );
                      },
                      icon: Icon(Icons.shopping_cart, color: Colors.black, size: 40)
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GPSTrackerScreen()), // 차후 기록 페이지 이동으로 변경
                        );
                      },
                      icon: Icon(Icons.bar_chart, color: Colors.black, size: 40)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
