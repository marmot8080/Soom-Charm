import 'package:contact/gamepage/weather/Rain_UI.dart';
import 'package:contact/gamepage/weather/Snow_UI.dart';
import 'package:contact/gamepage/weather/Sun_UI.dart';
import 'package:flutter/material.dart';
import 'package:contact/start.dart';
import 'package:contact/UserLogin/login.dart';
import 'package:contact/UserLogin/UserFind/signup.dart';
import 'package:contact/mainpage/MainScreen.dart';
import 'package:contact/mainpage/Settings_test.dart';
import 'package:contact/userlogin/userfind/PasswordFind.dart';
import 'package:contact/userlogin/userfind/IdFind.dart';
import 'package:contact/gamepage/Air_Bower_Game.dart';
import 'package:contact/gamepage/GameUI.dart';
import 'package:contact/roompage/Room_Create.dart';
import 'package:contact/roompage/Room_List_Screen.dart';
import 'package:contact/roompage/Room_Detail_Screen.dart';
import 'package:provider/provider.dart';

import 'gamepage/gameui_component/WeatherInfoViewModel.dart';
import 'gamepage/weather/Cloud_UI.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    '/': (context) => const StartPage(),

    '/userLogin/login': (context) => const LoginPage(),
    '/userLogin/userFind/signup': (context) => const SignupPage(),

    '/mainpage/MainScreen': (context) => const MainScreen(),
    '/mainpage/Settings_test': (context) => SettingsTestPage(),

    '/userlogin/userfind/PasswordFind': (context) => const PasswordFind(),
    '/userlogin/userfind/IdFind': (context) => const IdFindPage(),

    '/gamepage/Air_Bower_Game': (context) => AirBlowerGame(),
    '/gamepage/GameUI': (context) => GameUI(), // 인수 필요 없음

    '/gamepage/weather/Rain_UI': (context) => RainUI(),
    // '/gamepage/weather/Cloud_UI': (context) => CloudUI(),
    '/gamepage/weather/Cloud_UI': (context) {
      String windStrengthDescription = context.read<WeatherInfoViewModel>().getWindStrengthDescription();
      return CloudUI(windStrengthDescription: windStrengthDescription);
    },
    '/gamepage/weather/Sun_UI': (context) => SunUI(),
    '/gamepage/weather/Snow_UI': (context) => SnowUI(),

    '/roompage/Room_Create': (context) => RoomCreateScreen(),
    '/roompage/Room_List_Screen': (context) => RoomListScreen(),
    '/roompage/Room_Detail_Screen': (context) {
      final args = ModalRoute.of(context)?.settings.arguments;

      if (args == null || args is! String) {
        return Scaffold(
          appBar: AppBar(title: Text('오류')),
          body: Center(child: Text('유효한 방 ID가 전달되지 않았습니다.')),
        );
      }

      return RoomDetailScreen(roomId: args);
    },
  };
}