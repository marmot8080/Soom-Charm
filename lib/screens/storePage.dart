import 'package:flutter/material.dart';

class storePage extends StatelessWidget {
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
                        style: TextStyle(color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.monetization_on, color: Color(0xFFFFC648),
                          size: 24), // 코인 아이콘
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
