import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFCBE3FA),
        elevation: 0,
        title: Text(
          '상점',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 코인 보유량을 오른쪽에 배치하는 위젯
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFCBE3FA), // 하늘색 배경
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '5000', // 보유 코인 수
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.monetization_on,
                          color: Color(0xFFFFC648), size: 24), // 코인 아이콘
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            // 상점 아이템 목록
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 한 줄에 두 개씩
                crossAxisSpacing: 40, // 각 아이템 상자간의 가로 간격 늘리기
                mainAxisSpacing: 0.5, // 각 아이템 상자간의 세로 간격 줄이기
                childAspectRatio: 1.5, // 가로 세로 비율을 0.7로 설정하여 가로 길이 줄이기
                children: [
                  _buildItem(3, null, 300), // 하트 3개
                  _buildItem(1, 5, 450), // 하트 1개 X 5
                  _buildItem(1, 10, 900), // 하트 1개 X 10
                  _buildItem(1, 15, 1350), // 하트 1개 X 15
                  _buildItem(1, 20, 1800), // 하트 1개 X 20
                  _buildItem(1, 25, 2000), // 하트 1개 X 25
                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // 돈벌러 가기 기능 추가 필요
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                backgroundColor: Color(0xFFCBE3FA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                '돈벌러 가기',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 상점 아이템 위젯
  Widget _buildItem(int heartCount, int? multiple, int price) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 아이템 박스
        Container(
          padding: EdgeInsets.symmetric(
              vertical: 30, horizontal: 30), // 상자 내부 세로 여백 증가
          width: 160,
          decoration: BoxDecoration(
            color: Color(0xFFCBEFFA), // 색상을 CBEFFA로 변경
            borderRadius: BorderRadius.circular(20), // 모서리를 더 둥글게
          ),
          child: Column(
            children: [
              // 하트 아이콘 생성
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    heartCount, // heartCount만큼 하트 아이콘 생성
                    (index) => Icon(Icons.favorite,
                        color: Color(0xFFFF6D7A), size: 24),
                  ),
                  if (multiple != null) // X와 숫자 텍스트 추가
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        'X $multiple',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8), // 간격 추가
        // 가격을 표시하는 부분
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.monetization_on,
                color: Color(0xFFFFC648), size: 24), // 코인 아이콘
            SizedBox(width: 4),
            Text(
              '$price',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
