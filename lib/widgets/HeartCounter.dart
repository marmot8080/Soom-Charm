import 'package:flutter/material.dart';
import 'package:soom_charm/screens/StorePage.dart';

class HeartCounter extends StatelessWidget {
  final int heartCount; // 하트 개수

  const HeartCounter({Key? key, required this.heartCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.01,
        vertical: MediaQuery.of(context).size.height * 0.001,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFCBE3FA), // 하늘색 배경
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // 빨간 하트와 회색 하트 표시
          Row(
            children: List.generate(
              heartCount <= 5 ? heartCount : 5, // 5개 이하 하트만 빨간색으로 표시
                  (index) => Icon(
                Icons.favorite,
                color: Colors.red,
                size: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
          ),
          // 회색 하트 표시 (5개에서 heartCount만큼만 빨간색, 나머지는 회색)
          if (heartCount < 5)
            Row(
              children: List.generate(
                5 - heartCount, // 남은 회색 하트
                    (index) => Icon(
                  Icons.favorite,
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.height * 0.025,
                ),
              ),
            ),
          // + 추가
          if (heartCount > 5)
            Text(
              '+${heartCount - 5}', // 5개 초과한 부분
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Colors.black,
              ),
            ),
          // 상점 페이지 이동 버튼
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StorePage()), // 상점 페이지 이동
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
