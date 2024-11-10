import 'package:flutter/material.dart';
import '../gamepage/GameUI.dart';

class RoomDetailScreen extends StatelessWidget {
  final String roomId;

  RoomDetailScreen({required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('방 상세 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 게임 시작 버튼 클릭 시 GameUI로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameUI(),
                  ),
                );
              },
              child: Text('게임 시작'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // 버튼 배경색
                textStyle: TextStyle(fontSize: 18), // 텍스트 크기 설정
              ),
            ),
          ],
        ),
      ),
    );
  }
}