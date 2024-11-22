import 'package:flutter/material.dart';
import 'package:soom_charm/util/SharedPreferenceManager.dart';
import 'package:soom_charm/screens/StorePage.dart';

class HeartCounter extends StatefulWidget {
  const HeartCounter({Key? key}) : super(key: key);

  @override
  _HeartCounter createState() => _HeartCounter();
}

class _HeartCounter extends State<HeartCounter> {
  late SharedPreferenceManager spManager;
  late int _heartCount;
  late double _widgetSize;

  @override
  void initState() {
    super.initState();
    _initializeHeart();
  }

  Future<void> _initializeHeart() async {
    spManager = SharedPreferenceManager();
    spManager.initInstance();

    _heartCount = await spManager.getHeartCount() ?? 0;

    setState(() {
      _widgetSize = MediaQuery.of(context).size.width * 0.04;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.01,
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
              _heartCount <= 5 ? _heartCount : 5, // 5개 이하 하트만 빨간색으로 표시
                  (index) => Icon(
                Icons.favorite,
                color: Colors.red,
                size: _widgetSize,
              ),
            ),
          ),
          // 회색 하트 표시
          if (_heartCount < 5)
            Row(
              children: List.generate(
                5 - _heartCount,
                    (index) => Icon(
                  Icons.favorite,
                  color: Colors.grey,
                  size: _widgetSize,
                ),
              ),
            ),
          // + 추가
          if (_heartCount > 5)
            Text(
              ' +${_heartCount - 5}',
              style: TextStyle(
                fontSize: _widgetSize,
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
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: _widgetSize,
            ),
          ),
        ],
      ),
    );
  }
}
