import 'package:flutter/material.dart';

class AwsMatching extends StatelessWidget {
  const AwsMatching({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AWS 매칭'),
      ),
      body: Center(
        child: Text(
          '아직 시험단계입니다',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}