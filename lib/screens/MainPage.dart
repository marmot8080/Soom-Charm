import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:soom_charm/screens/GPSTrackerPage.dart';
import 'package:soom_charm/screens/GameStagePage.dart';
import 'package:soom_charm/screens/SettingPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _index = 1;

  List<Widget> _pages = [
    GPSTrackerPage(),
    GameStagePage(),
    SettingsPage()
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
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting')
        ],
      ),
    );
  }
}