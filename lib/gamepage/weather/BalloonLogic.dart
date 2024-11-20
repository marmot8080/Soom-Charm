import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BalloonWidget extends StatelessWidget {
  final double size;
  final bool bursting;

  const BalloonWidget({super.key, required this.size, required this.bursting});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: size,
      height: size * 1.5,
      child: bursting
          ? Lottie.asset('assets/balloon_exploded.json') // 풍선 터짐 애니메이션
          : Lottie.asset('assets/balloon.json'), // 기본 풍선 애니메이션
    );
  }
}