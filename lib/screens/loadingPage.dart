import 'package:flutter/material.dart';

void main() {
  runApp(SoomCharmApp());
}

class SoomCharmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loadingPage(),
    );
  }
}

class loadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            // 상단 제목
            Container(
            color: Color(0xFFCBE3FA), // 하늘색 배경
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '횡경막 호흡법',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
              // 이미지 설명 부분
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Upper Chest\nBreathing',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Image.asset(
                          'assets/upper_chest.png', // 대체할 이미지 경로
                          width: 100,
                          height: 150,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Belly\nBreathing',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Image.asset(
                          'assets/belly_breathing.png', // 대체할 이미지 경로
                          width: 100,
                          height: 150,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 하단 설명 텍스트
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '손을 배, 가슴에 올려 가슴은 움직이지 않고\n배가 움직이는 것을 느끼며 호흡해보세요!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
    ],
    ),
        ),
    );
  }
}


