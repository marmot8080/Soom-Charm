import 'package:flutter/material.dart';
import 'package:soom_charm/screens/mini_game/MiniGameTestPage.dart';
import 'package:soom_charm/widgets/GameStageButton.dart';
import 'package:soom_charm/screens/StorePage.dart';

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
                                MaterialPageRoute(builder: (context) => StorePage()),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameScreenTest(),
                      ),
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameScreenTest(),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameScreenTest(),
                      ),
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameScreenTest(),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameScreenTest(),
                      ),
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameScreenTest(),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
