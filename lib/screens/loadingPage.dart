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

    );
  }
}


