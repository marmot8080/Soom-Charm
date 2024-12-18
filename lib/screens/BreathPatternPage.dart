import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:soom_charm/util/SharedPreferenceManager.dart';
import 'package:soom_charm/screens/SettingPage.dart';
import 'package:soom_charm/screens/RankingPage.dart';
import 'package:soom_charm/widgets/DistanceBar.dart';

class BreathPatternPage extends StatefulWidget {
  @override
  _BreathPatternPageState createState() => _BreathPatternPageState();
}

class _BreathPatternPageState extends State<BreathPatternPage> {
  final String nickname = 'zoe'; // Dynamic nickname
  final double _maxDistance = 3.0; // 포인트 획들 기준 거리 정보
  late SharedPreferenceManager _spManager;
  late double? _totalDistance; // 총 이동 거리 정보
  double _progress = 0.0; // DistanceBar의 초기 progress 값

  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() async {
    _spManager = SharedPreferenceManager();
    _spManager.initInstance();
    _totalDistance = await _spManager.getTotalDistance();
    _totalDistance = _totalDistance ?? 0;

    _startAnimation(); // 페이지 로드 시 애니메이션 시작
  }

  void _startAnimation() {
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      // 타이머 간격을 줄임
      if (_progress >= 0.6) {
        timer.cancel();
      } else {
        setState(() {
          _progress += 0.04; // Progress 값을 점진적으로 증가
        });
      }
    });
  }

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
            Icon(
              Icons.person,
              color: Colors.black,
              size: MediaQuery.of(context).size.width * 0.12,
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
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black), // 설정 아이콘
            onPressed: () {
              // 설정 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '지금까지 총 ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        TextSpan(
                          text: '${_totalDistance}km', // 총 이동 거리 변수
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '다음 스테이지까지는 ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        TextSpan(
                          text: '${_maxDistance - _totalDistance! % _maxDistance}km ', // 남은 거리 정보 변수
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
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: _progress),
                    duration: Duration(seconds: 2),
                    builder: (context, double value, child) {
                      return DistanceBar(value: value);
                    },
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${_totalDistance! % _maxDistance}km / ${_maxDistance}km',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22),
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
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16), // Space between title and chart
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return Text('13');
                                  case 1:
                                    return Text('14');
                                  case 2:
                                    return Text('15');
                                  case 3:
                                    return Text('16');
                                  case 4:
                                    return Text('17');
                                  case 5:
                                    return Text('18');
                                  case 6:
                                    return Text('19');
                                  default:
                                    return Text('');
                                }
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 20),
                              FlSpot(1, 23),
                              FlSpot(2, 22),
                              FlSpot(3, 24),
                              FlSpot(4, 22),
                              FlSpot(5, 25),
                              FlSpot(6, 26),
                            ],
                            isCurved: true,
                            barWidth: 4,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(show: false),
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100], // 버튼 배경색
                  foregroundColor: Colors.black, // 버튼 텍스트 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RankingPage()),
                  );
                },
                child: Text(
                  'Game Ranking',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
