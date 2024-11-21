import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences 추가

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int point = 0; // 포인트 초기값

  @override
  void initState() {
    super.initState();
    _initializePoint();
  }

  Future<void> _initializePoint() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      point = prefs.getInt('point') ?? 0; // SharedPreferences에서 포인트 로드
    });
  }

  Future<void> _buyHeart(int heartCount, int price) async {
    final prefs = await SharedPreferences.getInstance();

    int currentPoint = prefs.getInt('point') ?? 0;
    if (currentPoint >= price) {
      prefs.setInt('point', currentPoint - price); // 포인트 차감

      int currentHeartCount = prefs.getInt('heartCount') ?? 0;
      prefs.setInt('heartCount', currentHeartCount + heartCount); // 하트 추가

      // 업데이트된 포인트 값 반영
      setState(() {
        point = currentPoint - price;
      });
    } else {
      // 포인트 부족 시 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('포인트가 부족합니다!')),
      );
    }
  }

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
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
            // 포인트 표시
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFCBE3FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$point', // 동적으로 포인트 값 표시
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.monetization_on,
                          color: Color(0xFFFFC648), size: 24),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // 상점 아이템 목록
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 0.5,
                childAspectRatio: 1.3,
                children: [
                  _buildItem(context, 3, 300),
                  _buildItem(context, 5, 450),
                  _buildItem(context, 10, 900),
                  _buildItem(context, 15, 1350),
                  _buildItem(context, 20, 1800),
                  _buildItem(context, 25, 2000),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int heartCount, int price) {
    return GestureDetector(
      onTap: () async {
        await _buyHeart(heartCount, price); // 하트 구매 후 포인트 업데이트
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$heartCount개의 하트를 구매했습니다!')),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            width: 160,
            decoration: BoxDecoration(
              color: Color(0xFFCBEFFA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: Color(0xFFFF6D7A), size: 24),
                    SizedBox(width: 4),
                    Text(
                      'X $heartCount',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.monetization_on,
                  color: Color(0xFFFFC648), size: 24),
              SizedBox(width: 4),
              Text(
                '$price',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
