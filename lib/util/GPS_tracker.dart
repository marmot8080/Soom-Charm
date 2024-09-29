import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GPSTracker extends ChangeNotifier {
  double totalDistance = 0.0;
  double speedInKmh = 0.0;
  Position? _previousPosition;
  DateTime? _lastAlertTime;

  // 위치 추적 시작
  Future<void> startTracking() async {
    // 위치 권한 확인 및 요청
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    // 위치 추적 리스너 등록
    Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // 최소 10미터 이동 후 업데이트
    )).listen((Position position) {

      if (_previousPosition != null) {
        // 이동 속도 계산 (m/s)
        double speedInMetersPerSecond = position.speed; // 속도(m/s)
        speedInKmh = speedInMetersPerSecond * 3.6; // km/h로 변환

        // 시속 30km 이상일 경우 경고
        if (speedInKmh > 30) {
          DateTime now = DateTime.now();

          // 마지막 경고 시간이 없거나, 30초 이상 지났을 때
          if (_lastAlertTime == null || now.difference(_lastAlertTime!).inSeconds > 30) {
            _lastAlertTime = now;  // 현재 시간으로 업데이트
            notifyListeners();     // 경고 메시지 알림
          }
        } else {
          totalDistance += Geolocator.distanceBetween(
            _previousPosition!.latitude,
            _previousPosition!.longitude,
            position.latitude,
            position.longitude,
          ) / 1000;
        }
      }

      _previousPosition = position;
      notifyListeners(); // 거리 변경 시 알림
    });
  }

  // 위치 추적 중지
  void stopTracking() {
    _previousPosition = null;
    totalDistance = 0.0;
    notifyListeners(); // 거리 초기화 시 알림
  }
}
