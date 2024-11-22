import 'package:flutter/material.dart';
import 'package:soom_charm/util/SharedPreferenceManager.dart';
import 'package:soom_charm/screens/MainPage.dart';

class PointCounter extends StatefulWidget {
  const PointCounter({Key? key}) : super(key: key);

  @override
  _PointCounter createState() => _PointCounter();
}

class _PointCounter extends State<PointCounter> {
  late SharedPreferenceManager spManager;
  late int point;

  @override
  void initState() {
    super.initState();

    _initializePointCount();
  }

  Future<void> _initializePointCount() async {
    spManager = SharedPreferenceManager();
    spManager.initInstance();

    point = await spManager.getPoint() ?? 0;
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
                size: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                ' $point',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
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
                  size: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
