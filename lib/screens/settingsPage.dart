import 'package:flutter/material.dart';

class settingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        CircleAvatar(
        radius: 40,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.person, size: 50, color: Colors.black),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '개똥이',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('프로필 수정'),
                SizedBox(width: 8),
                Icon(Icons.edit, size: 16),
              ],
            ),
          ],
        ),
        ],
      ),
            SizedBox(height: 24),
            // 슬라이더 섹션
            _buildSliderSection('배경음'),
            _buildSliderSection('효과음'),
            _buildSliderSection('전체 소리'),
            _buildSliderSection('감도 설정'),
            SizedBox(height: 24),
            // GPS 설정 섹션
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('GPS', style: TextStyle(fontSize: 18)),
                Switch(value: true, onChanged: (bool value) {}),
              ],
            ),
    ],


    ),

      ),
    );
  }
}


// 슬라이더 섹션 UI 빌더 함수
Widget _buildSliderSection(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 18)),
            Icon(Icons.volume_up),
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


