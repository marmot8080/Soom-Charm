import 'package:flutter/material.dart';

class recorderGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCBE3FA), // 배경색 설정

      body: Stack(
        children: [
          // 텍스트를 화면 위쪽 가운데에 배치
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0), // 위쪽 여백 추가
              child: Text(
                '리코더를 후후 불어봐!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // 리코더 이미지를 화면 중앙에 배치, 크기 키움
          Center(
            child: Image.asset(
              '../assets/images/recorder.png', // 리코더 이미지 경로
              height: 485, // 리코더 사진의 높이를 400으로 설정하여 더 크게
            ),
          ),
      ]),
    );
  }
}
