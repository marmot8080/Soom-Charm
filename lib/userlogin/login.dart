import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          // child: Text(
          //   "숨챰",
          //   style: TextStyle(
          //     fontSize: 45,  // 글씨 크기
          //     fontWeight: FontWeight.bold,  // 글씨 굵게
          //     color: Colors.black,  // 검정색 텍스트
          //   ),
          // ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,  // AppBar 배경색 흰색
        iconTheme: const IconThemeData(color: Colors.black),  // 뒤로가기 버튼 검은색
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,  // 배경색 흰색
          padding: const EdgeInsets.all(30),  // 전체 여백
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),  // 숨참과 로그인 입력 필드 사이의 여백을 늘림
                  const Text(
                    "숨챰",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 80),  // '숨참'과 로그인 입력 사이 여백 추가
                  emailInput(),
                  const SizedBox(height: 20),
                  passwordInput(),
                  const SizedBox(height: 20),
                  loginButton(),
                  const SizedBox(height: 20),  // 버튼과 하단 간격

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/userlogin/userfind/IdFind'),
                        child: const Text(
                          "아이디찾기",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/userlogin/userfind/PasswordFind'),
                        child: const Text(
                          "비밀번호찾기",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/userLogin/userFind/signup'),
                        child: const Text(
                          "회원가입",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  // 소셜 로그인 버튼들
                  const SizedBox(height: 220),  // 소셜 로그인 버튼들 위 여백 조정
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // 카카오 로그인 처리
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/kakao.png'),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              '카카오톡 로그인',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),  // 카카오톡과 구글 간의 간격
                      GestureDetector(
                        onTap: () {
                          // 구글 로그인 처리
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/google.png'),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              '구글 로그인',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),  // 구글과 애플 간의 간격
                      GestureDetector(
                        onTap: () {
                          // 애플 로그인 처리
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/apple.png'),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              '애플 로그인',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _emailController,
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return '아이디를 입력하세요.';
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '이메일을 입력하세요',
        hintStyle: TextStyle(color: Colors.black),  // 힌트 텍스트 색상
        labelText: '아이디',
        labelStyle: TextStyle(color: Colors.black),  // 라벨 색상
      ),
      style: const TextStyle(color: Colors.black),  // 입력 텍스트 색상
    );
  }

  TextFormField passwordInput() {
    return TextFormField(
      controller: _pwdController,
      obscureText: true,
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return '비밀번호를 입력하세요.';
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '비밀번호',
        hintStyle: TextStyle(color: Colors.black),  // 힌트 텍스트 색상
        labelText: '비밀번호',
        labelStyle: TextStyle(color: Colors.black),  // 라벨 색상
      ),
      style: const TextStyle(color: Colors.black),  // 입력 텍스트 색상
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_key.currentState!.validate()) {
          try {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                email: _emailController.text, password: _pwdController.text)
                .then((_) => Navigator.pushNamed(context, "/mainpage/MainScreen"));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              debugPrint('등록된 사용자가 없습니다.');
            } else if (e.code == 'wrong-password') {
              debugPrint('비밀번호가 틀렸습니다.');
            }
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,  // 버튼 배경색 흰색
        foregroundColor: Colors.black,  // 버튼 텍스트 색상 검은색
        side: BorderSide(color: Colors.black),  // 버튼 테두리 색상
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),  // 버튼 모서리 둥글게
        ),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),  // 내부 여백 추가
      ),
      child: const Text(
        "로그인",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}