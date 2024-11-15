import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  late final SharedPreferences prefs;

  void initInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setLastLoginTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();

    // 현재 시간을 유닉스 시간(초)으로 변환하여 저장
    await prefs.setInt('lastLoginTime', now.millisecondsSinceEpoch);
  }

  Future<int?> getLastLoginTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 현재 시간을 유닉스 시간(초)으로 변환하여 저장
    int? _lastLoginTime = await prefs.getInt('lastLoginTime');

    return _lastLoginTime;
  }

  void setHeartCount(int heartCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('heartCount', heartCount);
  }

  Future<int?> getHeartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? heartCount = await prefs.getInt('heartCount');

    return heartCount;
  }
}