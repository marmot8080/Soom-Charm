import 'package:flutter/material.dart';
import 'package:soom_charm/util/SharedPreferenceManager.dart';

class GameStageButton extends StatelessWidget {
  final SharedPreferenceManager spManager = SharedPreferenceManager();

  final String imagePath; // 버튼 이미지 경로
  final Widget targetPage; // 이동할 페이지

  GameStageButton({
    Key? key,
    required this.imagePath,
    required this.targetPage,
  }) : super(key: key);

  // 하트 개수를 감소시키는 비동기 메서드
  Future<void> _decreaseHeartCount(BuildContext context) async {
    int? currentHeartCount = await spManager.getHeartCount();
    if (currentHeartCount != null && currentHeartCount > 0) {
      spManager.setHeartCount(currentHeartCount - 1);

      // 페이지 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      );
    } else {
      // 하트가 부족할 때 처리 (예: 알림 표시)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("하트가 부족합니다!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _decreaseHeartCount(context), // 비동기 메서드 호출
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: MediaQuery.of(context).size.height * 0.004,
          ),
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
      ),
    );
  }
}
