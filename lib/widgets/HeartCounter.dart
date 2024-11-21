import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/StorePage.dart'; // SharedPreferences 직접 사용

class HeartCounter extends StatefulWidget {
  const HeartCounter({Key? key}) : super(key: key);

  @override
  _HeartCounterState createState() => _HeartCounterState();
}

class _HeartCounterState extends State<HeartCounter> {
  int heartCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeHeartCount();
  }

  Future<void> _initializeHeartCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      heartCount = prefs.getInt('heartCount') ?? 0; // SharedPreferences에서 하트 수 가져오기
    });
  }

  Future<void> _refreshHeartCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      heartCount = prefs.getInt('heartCount') ?? 0; // SharedPreferences에서 갱신된 하트 수 가져오기
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.01,
        vertical: MediaQuery.of(context).size.height * 0.001,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFCBE3FA),
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
          // 회색 하트 표시
          if (heartCount < 5)
            Row(
              children: List.generate(
                5 - heartCount,
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
              ' +${heartCount - 5}',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Colors.black,
              ),
            ),
          // 상점 페이지 이동 버튼
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StorePage()),
              );
              _refreshHeartCount(); // 상점 페이지 종료 후 하트 수 갱신
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * 0.025,
            ),
          ),
        ],
      ),
    );
  }
}
