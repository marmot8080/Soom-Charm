import 'package:flutter/material.dart';

class DistanceBar extends StatelessWidget {
  final double value; // 0.0 ~ 1.0 사이의 값
  final Color fillColor;
  final Color backgroundColor;
  final double height;

  const DistanceBar({
    Key? key,
    required this.value,
    this.fillColor = Colors.lightGreenAccent,
    this.backgroundColor = Colors.grey,
    this.height = 10,
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
