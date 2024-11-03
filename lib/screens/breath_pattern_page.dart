import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final String nickname = '숨챰님'; // Dynamic nickname

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/user_icon.png'), // Left user icon image
          onPressed: () {},
        ),
        title: Text(
          nickname, // Display dynamic nickname
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Divider(thickness: 1, color: Colors.grey),
            SizedBox(height: 16),
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
                  Text(
                    '지금까지 총 15.5 km를 움직이셨어요!',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '다음 스테이지까지는 3km 남았어요!',
                    style: TextStyle(fontSize: 14, color: Colors.green),
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
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '나의 호흡량 변화', // Placeholder for chart title
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Here you would add your line chart widget with breathing data
              // Example: LineChart(data: breathingData),
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
                    'assets/icon_settings.png'), // Left bottom icon image
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset(
                    'assets/icon_cart.png'), // Middle bottom icon image
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset(
                    'assets/icon_chart.png'), // Right bottom icon image
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
