import 'package:contact/firebase_options.dart';
import 'package:contact/start.dart';
import 'package:contact/userlogin/userfind/IdFind.dart';
import 'package:contact/userlogin/userfind/PasswordFind.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:contact/home.dart';
import 'package:contact/UserLogin/login.dart';
import 'package:contact/UserLogin/UserFind/signup.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'mainpage/MainScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  KakaoSdk.init(nativeAppKey: 'YOUR_KAKAO_REST_API_KEY');

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
        '/userLogin/login': (context) => const LoginPage(),
        '/userLogin/userFind/signup': (context) => const SignupPage(),
        '/mainpage/MainScreen': (context) => const MainScreen(),
        //'/mainpageSecond': (context) => const MainPageSecond(),
        '/userlogin/userfind/PasswordFind': (context) => const PasswordFind(),
        '/userlogin/userfind/IdFind': (context) => const IdFindPage(),
      },
    );
  }
}
