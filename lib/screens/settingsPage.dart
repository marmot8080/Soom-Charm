import 'package:flutter/material.dart';

class settingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('설정', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 섹션
              Row(
                children: [
                  CircleAvatar(
                    radius: size.width * 0.08, // 크기를 줄임
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: size.width * 0.12, color: Colors.black),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '개똥이',
                        style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text('프로필 수정', style: TextStyle(fontSize: size.width * 0.035)), // 텍스트 크기 줄임
                          SizedBox(width: 8),
                          Icon(Icons.edit, size: size.width * 0.04),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03), // 간격을 줄임
              // 슬라이더 섹션
              _buildSliderSection('배경음', size),
              _buildSliderSection('효과음', size),
              _buildSliderSection('전체 소리', size),
              _buildSliderSection('감도 설정', size),
              SizedBox(height: size.height * 0.01), // 간격을 줄임
              // GPS 설정 섹션
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('GPS', style: TextStyle(fontSize: size.width * 0.03)), // 텍스트 크기 줄임
                  Transform.scale(
                    scale: 0.8,  // 스위치 크기를 0.8배로 줄임
                    child: Switch(
                      value: true,
                      onChanged: (bool value) {},
                      activeTrackColor: Colors.grey,
                      inactiveThumbColor: Colors.black,  // 비활성화 시 버튼 색상 (회색)
                      inactiveTrackColor: Colors.grey,  // 비활성화 시 트랙 색상 (밝은 회색)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 슬라이더 섹션 UI 빌더 함수
  Widget _buildSliderSection(String title, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0), // 패딩을 줄임
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: size.width * 0.03)), // 텍스트 크기 줄임
              Icon(Icons.volume_up, size: size.width * 0.05),
            ],
          ),
          Slider(
            value: 0.5,
            onChanged: (double value) {},
            activeColor: Colors.black,
            inactiveColor: Colors.grey[300],
            // 슬라이더의 크기는 기본적으로 자동으로 조정됩니다.
          ),
          Divider(height: 8), // 구분선의 높이를 줄임
        ],
      ),
    );
  }
}
