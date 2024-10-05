import 'package:flutter/material.dart';

void main() {
  runApp(SoomCharmApp());
}

class SoomCharmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loadingPage(),
    );
  }
}

class loadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            // 상단 제목
            Container(
            color: Color(0xFFCBE3FA), // 하늘색 배경
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '횡경막 호흡법',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
    ],
    ),
        ),
    );
  }
}


