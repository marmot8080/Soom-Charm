import 'package:flutter/material.dart';

class DistanceBar extends StatelessWidget {
  final double value; // 게이지 값 (0.0 ~ 1.0 사이의 값)
  final Color fillColor; // 게이지 바 색
  final Color backgroundColor; // 게이지 배경 색
  final double height; // 게이지 두께 (세로 두께)

  const DistanceBar({
    Key? key,
    required this.value,
    this.fillColor = Colors.lightGreenAccent,
    this.backgroundColor = Colors.grey,
    this.height = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: value, // value 값에 따라 게이지가 차는 부분
            child: Container(
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
