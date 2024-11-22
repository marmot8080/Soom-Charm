import 'package:flutter/material.dart';
import 'package:soom_charm/util/SharedPreferenceManager.dart';
import 'package:soom_charm/screens/MainPage.dart';

class PointCounter extends StatefulWidget {
  const PointCounter({Key? key}) : super(key: key);

  @override
  _PointCounter createState() => _PointCounter();
}

class _PointCounter extends State<PointCounter> {
  late SharedPreferenceManager _spManager;
  late int _point;
  late double _widgetSize;

  @override
  void initState() {
    super.initState();

    _initializePointCount();
  }

  Future<void> _initializePointCount() async {
    _spManager = SharedPreferenceManager();
    _spManager.initInstance();

    _point = await _spManager.getPoint() ?? 0;

    setState(() {
      _widgetSize = MediaQuery.of(context).size.width * 0.04;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.005,
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
                size: _widgetSize,
              ),
              Text(
                ' $_point',
                style: TextStyle(
                  fontSize: _widgetSize,
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
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: _widgetSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
