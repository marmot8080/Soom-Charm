import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFCBE3FA), // 하늘색 배경
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.favorite, color: Color(0xFFFF6D7A), size: 30),
                        Icon(Icons.favorite, color: Color(0xFFFF6D7A), size: 30),
                        Icon(Icons.favorite, color: Color(0xFFFF6D7A), size: 30),
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
                  children: const [
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
                backgroundColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                  child: Image.asset(
                    'assets/mainimage.png', // 경로 수정
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
                    Navigator.pushNamed(context, '/roompage/Room_List_Screen'); // Named route 사용
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    backgroundColor: Color(0xFFCBE3FA), // 버튼 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(120, 50),
                  ),
                  child: const Text(
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
                  // 설정 아이콘 버튼
                  IconButton(
                    icon: Icon(Icons.settings, size: 40),
                    onPressed: () {
                      Navigator.pushNamed(context, '/mainpage/Settings_test'); // Named route 사용
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart, size: 40),
                    onPressed: () {
                      Navigator.pushNamed(context, '/gamepage/weather/Rain_UI');
                    },
                  ),
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