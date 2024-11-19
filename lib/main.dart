import 'package:flutter/material.dart';
import 'package:soom_charm/util/SharedPreferenceManager.dart';
import 'package:soom_charm/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late SharedPreferenceManager spManager;

  @override
  void initState() {
    super.initState();

    spManager = SharedPreferenceManager();
    spManager.initInstance();

    spManager.setHeartCount(6);
    spManager.setPoint(0);
    spManager.setTotalDistance(0.99);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}