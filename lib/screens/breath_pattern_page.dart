import 'package:flutter/material.dart';

void main() {
  runApp(breath_pattern_page());
}

class breath_pattern_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: breathPatternScreen(),
    );
  }
}

class breathPatternScreen extends StatelessWidget {
  final String nickname = '숨챰님'; // Dynamic nickname
  final double remainingDistance = 3.0; // 실시간 업데이트가 가능한 남은 거리 정보
  final double totalDistance = 15.5; // 실시간 업데이트가 가능한 총 이동 거리 정보

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // 뒤로가기 화살표 아이콘
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 돌아가기
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/user_icon.png', // 사용자 아이콘 이미지
              width: 50,
              height: 50,
            ),
            SizedBox(width: 8),
            // Blue Box with Bold Text for Nickname
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[100], // 파란색 박스
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                nickname, // 동적 닉네임 표시
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // 텍스트 볼드 처리
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Divider(thickness: 1, color: Colors.grey),
            SizedBox(height: 12),
            // Cumulative Distance Section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '총 누적 거리',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Dynamic Total Distance Text
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '지금까지 총 ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        TextSpan(
                          text: '${totalDistance}km', // 총 이동 거리 변수
                          style: TextStyle(
                            fontSize: 16, // 크기를 더 크게
                            fontWeight: FontWeight.bold, // 두껍게
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '를 움직이셨어요!',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  // Dynamic Text with Remaining Distance
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '다음 스테이지까지는 ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        TextSpan(
                          text: '${remainingDistance}km ', // 남은 거리 정보 변수
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                        TextSpan(
                          text: '남았어요!',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  DistanceBar(
                    value: 0.6, // Example progress value (60%)
                  ),
                  SizedBox(height: 4),
                  Text(
                    '3km / 5km',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Line Chart Section
            Container(
              width: 290,
              height: 300,
              padding: EdgeInsets.all(16.0), // Padding for inner spacing
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '나의 호흡량 변화',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold, // Make text bold
                    ),
                  ),
                  SizedBox(height: 11), // Space between title and chart
                  Expanded(
                    child: Center(
                        //child: Image.asset(
                        //'assets/breath_pattern.png', // Placeholder image path for chart
                        // width: double.infinity,
                        //fit: BoxFit.contain,
                        //),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset(
                    'assets/images/setting_icon.png'), // Left bottom icon image
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset(
                    'assets/images/shopping_icon.png'), // Middle bottom icon image
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset(
                    'assets/images/chart_icon.png'), // Right bottom icon image
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DistanceBar widget
class DistanceBar extends StatelessWidget {
  final double value; // 0.0 ~ 1.0 사이의 값
  final Color fillColor;
  final Color backgroundColor;
  final double height;

  const DistanceBar({
    Key? key,
    required this.value,
    this.fillColor = Colors.lightGreenAccent,
    this.backgroundColor = Colors.grey,
    this.height = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: value, // value 값에 따라 게이지가 차는 부분
            child: Container(
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
