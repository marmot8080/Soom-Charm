import 'package:flutter/material.dart';

class GameStageButton extends StatelessWidget {
  final String imagePath; // 버튼 이미지 경로
  final Widget targetPage; // 이동할 페이지

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
            border: Border.all(color: Colors.black, width: MediaQuery.of(context).size.height * 0.004),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.height * 0.08,
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ),
        )
    );
  }
}
