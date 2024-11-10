import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PasswordFind extends StatefulWidget {
  const PasswordFind({super.key});

  @override
  _PasswordFindState createState() => _PasswordFindState();
}

class _PasswordFindState extends State<PasswordFind> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref(); // Realtime Database 참조
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _isEmailSent = false; // 이메일 전송 여부

  // 비밀번호 재설정 이메일 전송 함수
  Future<void> sendPasswordResetEmail() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("이름과 이메일을 모두 입력해주세요.")),
      );
      return;
    }

    // Realtime Database에서 사용자 정보 조회
    DatabaseEvent event = await _dbRef.child('users').orderByChild('email').equalTo(email).once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.exists) {
      // 이메일이 DB에 존재하는 경우
      var userData = snapshot.value as Map<dynamic, dynamic>;
      bool nameMatches = userData.values.any((user) => user['name'] == name); // 이름 확인

      if (nameMatches) {
        try {
          await _auth.sendPasswordResetEmail(email: email);
          setState(() {
            _isEmailSent = true; // 이메일이 전송된 상태로 변경
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("비밀번호 재설정 이메일이 전송되었습니다.")),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("비밀번호 재설정 이메일 전송에 실패했습니다: $e")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("입력한 이름과 이메일이 일치하지 않습니다.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("이메일이 등록되어 있지 않습니다.")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose(); // 이름 텍스트 필드 컨트롤러 해제
    emailController.dispose(); // 이메일 텍스트 필드 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 찾기'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: '이름 입력',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: '이메일 입력',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isEmailSent ? null : sendPasswordResetEmail, // 이메일이 전송되었으면 버튼 비활성화
              child: Text('비밀번호 재설정 이메일 전송'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            if (_isEmailSent) ...[ // 이메일이 전송된 경우에만 재전송 버튼 및 로그인 화면으로 돌아가기 버튼 표시
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendPasswordResetEmail, // 재전송 버튼
                child: Text('재전송'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 로그인 화면으로 돌아가기
                },
                child: Text('로그인 화면으로 돌아가기'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  //backgroundColor: Colors.grey, // 배경색을 회색으로 설정
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}