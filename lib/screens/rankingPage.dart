import 'package:flutter/material.dart';

void main() {
  runApp(rankingPage());
}

class rankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RankingScreen(),
    );
  }
}

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  // 미니 게임 이름을 저장할 변수
  String miniGameTitle = '탁구공 오래띄우기';

  // 박스를 눌렀을 때 상태를 업데이트하는 함수
  void updateMiniGameTitle(int index) {
    setState(() {
      miniGameTitle = 'mini game_${index + 1}';
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Divider(height: 16, thickness: 1),
            Text(
              miniGameTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Rank List
            Container(
              width: screenSize.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Column(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}.',
                          style: TextStyle(
                            fontSize: 24,
                            color: index == 0
                                ? Colors.orange
                                : index == 1
                                ? Colors.grey
                                : index == 2
                                ? Colors.brown
                                : Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: screenSize.height * 0.06,
                            margin: EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Spacer(),
            // Bottom color boxes
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(9, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: GestureDetector(
                        onTap: () => updateMiniGameTitle(index),
                        child: _buildColorBox(
                          [
                            Colors.grey,
                            Colors.brown,
                            Colors.orange[200]!,
                            Colors.white,
                            Colors.yellow,
                            Colors.blue,
                            Colors.green,
                            Colors.lightGreen,
                            Colors.red
                          ][index],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorBox(Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
    );
  }
}