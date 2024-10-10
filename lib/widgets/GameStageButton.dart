import 'package:flutter/material.dart';

class GameStageButton extends StatelessWidget {
  final String imagePath;
  final Widget targetPage; // 이동할 페이지를 받음

  const GameStageButton({
    Key? key,
    required this.imagePath,
    required this.targetPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 4),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
        )
    );
  }
}
