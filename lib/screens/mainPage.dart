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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                        Icon(Icons.favorite,
                            color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
                        Icon(Icons.favorite,
                            color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
                        Icon(Icons.favorite,
                            color: Color(0xFFFF6D7A), size: 30), // 하트 색상 수정
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
            // 폐 이미지
            Center(
              child: CircleAvatar(
                radius: 130,
                backgroundColor: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                  child: Image.asset(
                    'assets/images/lungs.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Start 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameStagePage()), // 페이지 이동
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    backgroundColor: Color(0xFFCBE3FA), // 버튼 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(120, 50),
                  ),
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            // 하단 네비게이션 아이콘들
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.settings, size: 40),
                  Icon(Icons.shopping_cart, size: 40),
                  Icon(Icons.bar_chart, size: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 새로운 페이지 StagePage 정의 나중에 새로운 페이지로 나눌 예정
class GameStagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainPage Second'),
      ),
      body: Center(
        child: Text(
          'This is the MainPageSecond!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
