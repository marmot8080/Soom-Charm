import 'package:flutter/material.dart';
import 'package:soom_charm/screens/BreathPatternPage.dart';
import 'package:soom_charm/screens/GPSTrackerPage.dart';
import 'package:soom_charm/screens/GameStagePage.dart';
import 'package:soom_charm/screens/SettingPage.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;

  MainPage({Key? key, this.initialIndex = 1}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _index;

  @override
  void initState() {
    super.initState();

    _index = widget.initialIndex; // 초기 인덱스 값 설정
  }

  // 하단 네비게이션 페이지 이동 리스트
  List<Widget> _pages = [
    GPSTrackerPage(),
    GameStagePage(),
    BreathPatternPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.speed), label: 'walk'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'my profile')
        ],
      ),
    );
  }
}