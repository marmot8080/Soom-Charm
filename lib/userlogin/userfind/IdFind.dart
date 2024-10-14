import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class IdFindPage extends StatefulWidget {
  const IdFindPage({super.key});

  @override
  _IdFindPageState createState() => _IdFindPageState();
}

class _IdFindPageState extends State<IdFindPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref(); // Realtime Database 참조
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? foundEmail; // 찾은 이메일을 저장할 변수

  // 이메일 찾기 함수
  Future<void> findEmail() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("이름과 전화번호를 모두 입력해주세요.")),
      );
      return;
    }

    // Realtime Database에서 사용자 정보 조회
    DatabaseEvent event = await _dbRef.child('users').orderByChild('phone').equalTo(phone).once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.exists) {
      // 전화번호가 DB에 존재하는 경우
      var userData = snapshot.value as Map<dynamic, dynamic>;
      bool nameMatches = userData.values.any((user) => user['name'] == name); // 이름 확인

      if (nameMatches) {
        // 일치하는 이메일 찾기
        foundEmail = userData.values.firstWhere((user) => user['name'] == name)['email']; // email 필드 확인
        setState(() {}); // 상태 업데이트
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("입력한 이름과 전화번호가 일치하지 않습니다.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("전화번호가 등록되어 있지 않습니다.")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose(); // 이름 텍스트 필드 컨트롤러 해제
    phoneController.dispose(); // 전화번호 텍스트 필드 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아이디 찾기'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '아이디 찾기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '이름',
                hintText: '예) 홍길동',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: '전화번호',
                hintText: '예) 01012345678',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  findEmail(); // '찾기' 버튼 클릭 시 이메일 찾기 함수 호출
                },
                child: const Text('찾기'),
              ),
            ),
            const SizedBox(height: 10),
            if (foundEmail != null) ...[ // 이메일이 찾은 경우
              Text(
                '찾은 이메일: $foundEmail',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              const SizedBox(height: 10),
            ],
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('로그인 화면으로 돌아가기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}