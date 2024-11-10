import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 상하 배치 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 좌우 가운데 정렬
          children: [
            const SizedBox(height: 20), // 상단에 약간의 공간 추가
            Center( // 이미지와 텍스트를 중앙에 배치
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '숨챰',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/mainimage.png', // 이미지 경로
                    width: 300,  // 이미지 너비 키우기
                    height: 300, // 이미지 높이 키우기
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30), // 아래쪽 여백 추가
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/userLogin/login'); // login.dart로 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCBE3FA), // 배경색을 #CBE3FA로 변경
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // 직사각형 모양 (모서리 반경 0)
                  ),
                ),
                child: const Text(
                  '시작하기',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black, // 글씨 색을 검정색으로 변경
                  ),
                ),
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}