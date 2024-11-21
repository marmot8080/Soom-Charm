import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soom_charm/screens/MainPage.dart';

class PointCounter extends StatefulWidget {
  const PointCounter({Key? key}) : super(key: key);

  @override
  _PointCounterState createState() => _PointCounterState();
}

class _PointCounterState extends State<PointCounter> {
  int point = 0;

  @override
  void initState() {
    super.initState();
    _initializePointCount();
  }

  Future<void> _initializePointCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      point = prefs.getInt('point') ?? 0; // SharedPreferences에서 포인트 가져오기
    });
  }

  Future<void> _refreshPointCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      point = prefs.getInt('point') ?? 0; // 포인트 갱신
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.001,
        vertical: MediaQuery.of(context).size.height * 0.001,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFCBE3FA),
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
                ' $point',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  color: Colors.black,
                ),
              ),
              // GPSTracker 페이지 이동 버튼
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage(initialIndex: 0,)), // GPSTracker 페이지 이동
                  );
                  _refreshPointCount(); // GPSTracker 종료 후 포인트 갱신
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
