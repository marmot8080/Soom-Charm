import 'package:flutter/material.dart';

class settingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('설정', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 기능
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '로그아웃',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 섹션
            Row(
              children: [
                // CircleAvatar의 크기를 화면 크기에 따라 조정
                CircleAvatar(
                  radius: size.width * 0.1, // 화면 너비의 10% 크기
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: size.width * 0.15, color: Colors.black),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '개똥이',
                      style: TextStyle(fontSize: size.width * 0.06, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text('프로필 수정'),
                        SizedBox(width: 8),
                        Icon(Icons.edit, size: size.width * 0.04),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05), // 간격을 화면 크기에 맞게 조정
            // 슬라이더 섹션
            _buildSliderSection('배경음', size),
            _buildSliderSection('효과음', size),
            _buildSliderSection('전체 소리', size),
            _buildSliderSection('감도 설정', size),
            SizedBox(height: size.height * 0.05),
            // GPS 설정 섹션
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('GPS', style: TextStyle(fontSize: size.width * 0.05)),
                Switch(value: true, onChanged: (bool value) {}),
              ],
            ),
          ],
        ),
      ),
    );
  }


  // 슬라이더 섹션 UI 빌더 함수
  Widget _buildSliderSection(String title, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: size.width * 0.05)),
              Icon(Icons.volume_up, size: size.width * 0.06),
            ],
          ),
          Slider(
            value: 0.5,
            onChanged: (double value) {},
            activeColor: Colors.black,
            inactiveColor: Colors.grey[300],
          ),
          Divider(), // 구분선 추가
        ],
      ),
    );
  }
}


