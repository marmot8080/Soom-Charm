import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdConfirmController = TextEditingController(); // 비밀번호 확인용 컨트롤러
  final TextEditingController _nameController = TextEditingController(); // 이름 입력 컨트롤러
  final TextEditingController _phoneController = TextEditingController(); // 전화번호 입력 컨트롤러

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                emailInput(),
                const SizedBox(height: 15),
                passwordInput(),
                const SizedBox(height: 15),
                confirmPasswordInput(),
                const SizedBox(height: 15),
                nameInput(),
                const SizedBox(height: 15),
                phoneInput(),
                const SizedBox(height: 15),
                submitButton(),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 이메일 입력 필드
  TextFormField emailInput() {
    return TextFormField(
      controller: _emailController,
      validator: (val) {
        if (val!.isEmpty) {
          return '이메일을 입력하세요.';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '이메일 주소를 입력하세요',
        labelText: '이메일 주소',
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 비밀번호 입력 필드
  TextFormField passwordInput() {
    return TextFormField(
      controller: _pwdController,
      obscureText: true,
      validator: (val) {
        if (val!.isEmpty) {
          return '비밀번호를 입력하세요.';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '비밀번호를 입력하세요.',
        labelText: '비밀번호',
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 비밀번호 확인 필드
  TextFormField confirmPasswordInput() {
    return TextFormField(
      controller: _pwdConfirmController,
      obscureText: true,
      validator: (val) {
        if (val != _pwdController.text) {
          return '비밀번호가 일치하지 않습니다.';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '비밀번호를 한 번 더 입력해주세요.',
        labelText: '비밀번호 확인',
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 이름 입력 필드
  TextFormField nameInput() {
    return TextFormField(
      controller: _nameController,
      validator: (val) {
        if (val!.isEmpty) {
          return '이름을 입력하세요.';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '예) 홍길동',
        labelText: '이름',
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 전화번호 입력 필드
  TextFormField phoneInput() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      validator: (val) {
        if (val!.isEmpty) {
          return '전화번호를 입력하세요.';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '예) 01012345678',
        labelText: '전화번호',
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 회원가입 버튼
  ElevatedButton submitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_key.currentState!.validate()) {
          try {
            // Firebase Authentication을 통해 사용자 생성
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _pwdController.text,
            );

            // 사용자 정보 저장을 위한 사용자 UID
            String uid = userCredential.user!.uid;

            // Firebase Realtime Database에 저장할 데이터 구조
            DatabaseReference dbRef = FirebaseDatabase.instance.ref('users/$uid');
            await dbRef.set({
              'email': _emailController.text,
              'name': _nameController.text,
              'phone': _phoneController.text,
            });

            // 가입 성공 후 로그인 화면으로 이동
            Navigator.pushNamed(context, '/userLogin/login');
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('비밀번호가 너무 약합니다.')),
              );
            } else if (e.code == 'email-already-in-use') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('이미 존재하는 이메일입니다.')),
              );
            }
          } catch (e) {
            print(e.toString());
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "회원가입",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}