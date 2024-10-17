import 'package:flutter/material.dart';
import 'package:soom_charm/screens/StorePage.dart';

class HeartCounter extends StatelessWidget {
  final int heartCount;

  const HeartCounter({Key? key, required this.heartCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.01,
        vertical: MediaQuery.of(context).size.height * 0.001,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFCBE3FA), // 하늘색 배경
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Row(
            children: List.generate(
              heartCount,
                  (index) => Icon(
                Icons.favorite,
                color: Colors.red,
                size: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StorePage()),
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
