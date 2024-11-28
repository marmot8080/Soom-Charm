import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:contact/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'Routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  await Firebase.initializeApp(
    name: 'hellotest',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: 'YOUR_KAKAO_REST_API_KEY');
  runApp(const MyApp());
}

String apiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY'] ?? '';

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
      routes: buildRoutes(), // buildRoutes()로 경로 설정
    );
  }
}