import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  @override
  _loadingPageState createState() => _loadingPageState();
}

class _loadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // AnimationController 초기화, 애니메이션 속도를 5초로 설정 (길게 설정할수록 느려짐)
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose(); // 애니메이션이 끝나면 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 크기 가져오기
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFCBE3FA), // 화면 전체에 하늘색 배경 적용
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 상단 제목
              Container(
                color: Color(0xFFCBE3FA), // 상단 배경색도 동일하게 적용
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '횡경막 호흡법',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // 이미지 설명 부분
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      // 첫 번째 이미지에 Expanded 적용
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/Loading_belly_breathing.png',
                            width: size.width * 0.7, // 화면 너비의 70%로 이미지 크기 조정
                            height: size.height * 0.50, // 화면 높이의 50%로 이미지 크기 조정
                            fit: BoxFit.contain, // 이미지 크기 맞추기
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 하단 설명 텍스트
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '손을 배, 가슴에 올려 가슴은 움직이지 않고\n배가 움직이는 것을 느끼며 호흡해보세요!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // 로딩 바 (애니메이션 속도 조정)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _controller.value,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.grey[800]!),
                      minHeight: 8,
                    );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
