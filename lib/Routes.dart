import 'package:contact/gamepage/weather/weather_component/Rain_UI.dart';
import 'package:contact/gamepage/weather/weather_component/Snow_UI.dart';
import 'package:contact/gamepage/weather/weather_component/Sun_UI.dart';
import 'package:flutter/material.dart';
import 'package:contact/start.dart';
import 'package:contact/UserLogin/login.dart';
import 'package:contact/UserLogin/UserFind/signup.dart';
import 'package:contact/mainpage/MainScreen.dart';
import 'package:contact/mainpage/Settings_test.dart';
import 'package:contact/userlogin/userfind/PasswordFind.dart';
import 'package:contact/userlogin/userfind/IdFind.dart';
import 'package:contact/gamepage/AwsMatching.dart';
import 'package:contact/gamepage/GameUI.dart';
import 'package:contact/roompage/Room_Create.dart';
import 'package:contact/roompage/Room_List_Screen.dart';
import 'package:contact/roompage/Room_Detail_Screen.dart';
import 'package:provider/provider.dart';

import 'gamepage/gameui_component/WeatherInfoViewModel.dart';
import 'gamepage/weather/weather_component/Cloud_UI.dart';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    '/': (context) => const StartPage(),

    '/userLogin/login': (context) => const LoginPage(),
    '/userLogin/userFind/signup': (context) => const SignupPage(),

    '/mainpage/MainScreen': (context) => const MainScreen(),
    '/mainpage/Settings_test': (context) => SettingsTestPage(),

    '/userlogin/userfind/PasswordFind': (context) => const PasswordFind(),
    '/userlogin/userfind/IdFind': (context) => const IdFindPage(),

    '/gamepage/AwsMatching': (context) => AwsMatching(),
    '/gamepage/GameUI': (context) => GameUI(), // 인수 필요 없음

    '/gamepage/weather/weather_component/Rain_UI': (context) {
      String windStrengthDescription = context.read<WeatherInfoViewModel>().getWindStrengthDescription();
      return RainUI(windStrengthDescription: windStrengthDescription);
    },
    // '/gamepage/weather/Cloud_UI': (context) => CloudUI(),
    '/gamepage/weather/weather_component/Cloud_UI': (context) {
      String windStrengthDescription = context.read<WeatherInfoViewModel>().getWindStrengthDescription();
      return CloudUI(windStrengthDescription: windStrengthDescription);
    },
    '/gamepage/weather/weather_component/Sun_UI': (context) {
      String windStrengthDescription = context.read<WeatherInfoViewModel>().getWindStrengthDescription();
      return SunUI(windStrengthDescription: windStrengthDescription);
    },
    '/gamepage/weather/weather_component/Snow_UI': (context) {
      String windStrengthDescription = context.read<WeatherInfoViewModel>().getWindStrengthDescription();
      return SnowUI(windStrengthDescription: windStrengthDescription);
    },

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