import 'package:flutter/material.dart';
import 'package:soom_charm/screens/MainPage.dart';

class PointCounter extends StatelessWidget {
  final int point; // 하트 개수

  const PointCounter({Key? key, required this.point}) : super(key: key);

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
          Row(
            children: [
              Icon(
                Icons.monetization_on,
                color: Color(0xFFFFC648),
                size: MediaQuery.of(context).size.height * 0.025,
              ),
              Text(
                ' ${point}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  color: Colors.black,
                ),
              ),
              // GPSTracker 페이지 이동 버튼
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage(initialIndex: 0,)), // GPSTracker 페이지 이동
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.height * 0.025,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
