import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  late final SharedPreferences prefs;

  void initInstance() async {
    prefs = await SharedPreferences.getInstance();
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

  void setPoint(int point) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('point', point);
  }

  Future<int?> getPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? point = await prefs.getInt('point');

    return point;
  }

  void setTotalDistance(double totalDistance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('totalDistance', totalDistance);
  }

  Future<double?> getTotalDistance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double? totalDistance = await prefs.getDouble('totalDistance');

    return totalDistance;
  }
}