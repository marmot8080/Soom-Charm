import 'package:flutter/material.dart';
import 'package:soom_charm/screens/mini_game/MiniGameTestPage.dart';
import 'package:soom_charm/widgets/GameStageButton.dart';
import 'package:soom_charm/screens/StorePage.dart';
import 'package:soom_charm/widgets/HeartCounter.dart';

class GameStagePage extends StatefulWidget {
  @override
  _GameStagePage createState() => _GameStagePage();
}

class _GameStagePage extends State<GameStagePage> {
  int _heartCount = 4;

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
                      icon: Icon(Icons.arrow_back, color: Colors.black, size: MediaQuery.of(context).size.height * 0.035)
                  ),
                  // 하트 아이콘들과 + 아이콘을 감싸는 컨테이너
                  HeartCounter(heartCount: _heartCount)
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
                        targetPage: MiniGameTestPage(),
                      ),
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameTestPage(),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameTestPage(),
                      ),
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameTestPage(),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameTestPage(),
                      ),
                      GameStageButton(
                        imagePath: "assets/images/lungs.png",
                        targetPage: MiniGameTestPage(),
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
