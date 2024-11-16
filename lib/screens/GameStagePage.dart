import 'package:flutter/material.dart';
import 'package:soom_charm/util/SharedPreferenceManager.dart';

import 'package:soom_charm/widgets/GameStageButton.dart';
import 'package:soom_charm/widgets/HeartCounter.dart';
import 'package:soom_charm/widgets/PointCounter.dart';

import 'package:soom_charm/screens/mini_game/MiniGameTestPage.dart';
import 'package:soom_charm/screens/mini_game/BonfireGamePage.dart';

class GameStagePage extends StatefulWidget {
  @override
  _GameStagePage createState() => _GameStagePage();
}

class _GameStagePage extends State<GameStagePage> {
  late SharedPreferenceManager spManager;
  late int? _point; // 포인트 값
  late int? _heartCount; // 하트 개수

  @override
  void initState() {
    super.initState();

    // 비동기 초기화 메서드 호출
    _initializeHeartCount();
    _initializePointCount();
  }

  @override
  void dispose(){
    super.dispose();
  }

  void _initializeHeartCount() async {
    spManager = SharedPreferenceManager();
    spManager.initInstance(); // 인스턴스 초기화

    _heartCount = await spManager.getHeartCount(); // 비동기 호출
    setState(() {
      _heartCount = _heartCount ?? 0;
    });
  }

  void _initializePointCount() async {
    spManager = SharedPreferenceManager();
    spManager.initInstance(); // 인스턴스 초기화

    _point = await spManager.getPoint(); // 비동기 호출
    setState(() {
      _point = _point ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 하트 아이콘과 타이틀 부분
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
                  // 포인트 아이콘과 + 아이콘을 감싸는 컨테이너
                  PointCounter(point: _point!),
                  // 하트 아이콘들과 + 아이콘을 감싸는 컨테이너
                  HeartCounter(heartCount: _heartCount!)
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
                        targetPage: BonfireGamePage(),
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
