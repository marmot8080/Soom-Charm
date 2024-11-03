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

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting the screen size for responsive layout
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
              '탁구공 오래띄우기',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Rank List
            Container(
              width: screenSize.width * 0.8, // Responsive width
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
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildColorBox(Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildColorBox(Colors.brown),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildColorBox(Colors.orange[200]!),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildColorBox(Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildColorBox(Colors.yellow),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildColorBox(Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildColorBox(Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildColorBox(Colors.lightGreen),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: _buildColorBox(Colors.red))
                ],
              ),
            )),
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
