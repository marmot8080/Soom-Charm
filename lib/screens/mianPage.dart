import 'package:flutter/material.dart';

void main() {
  runApp(SoomCharmApp());
}

class SoomCharmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '숨챰',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
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
                        Icon(Icons.favorite, color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
                        Icon(Icons.favorite, color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
                        Icon(Icons.favorite, color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
                        SizedBox(width: 4),
                        Icon(Icons.add, color: Colors.black, size: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 폐 상태와 텍스트 설명
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: '폐 단련 5일차..\n호흡근이 '),
                    TextSpan(
                      text: '5%',
                      style: TextStyle(
                        color: Color(0xFFFF6D7A), // 5% 색상 수정
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' 증가했습니다\n오늘도 화이팅!'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}