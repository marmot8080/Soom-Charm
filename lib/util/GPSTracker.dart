import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GPSTracker extends ChangeNotifier {
  double totalDistance = 0.0; // 총 이동거리
  double speedInKmh = 0.0;  // 현재 속도
  double speedLimit = 30; // 제한 속도
  Position? _previousPosition;  // 이전 저장 위치
  DateTime? _lastAlertTime; // 최근 경고 알림 시간

  GPSTracker({Key? key, required this.totalDistance}) : super();

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
        distanceFilter: 20, // 최소 20미터 이동 후 업데이트
    )).listen((Position position) {

      if (_previousPosition != null) {
        // 이동 속도 계산 (m/s)
        double speedInMetersPerSecond = position.speed; // 속도(m/s)
        speedInKmh = speedInMetersPerSecond * 3.6; // km/h로 변환

        // 제한 속도 초과시 경고
        if (speedInKmh > speedLimit) {
          DateTime now = DateTime.now();

          // 경고가 뜬 적이 없거나, 이전 경고 시간으로부터 30초를 초과했을 때
          if (_lastAlertTime == null || now.difference(_lastAlertTime!).inSeconds > 30) {
            _lastAlertTime = now;  // 현재 시간으로 업데이트
            notifyListeners();     // 제한 속도 초과시 알림
          }
        } else {
          // 총 이동거리 합산 (현재 위치 - 최근 위치)
          totalDistance += Geolocator.distanceBetween(
            _previousPosition!.latitude,
            _previousPosition!.longitude,
            position.latitude,
            position.longitude,
          ) / 1000;
        }
      }

      _previousPosition = position; // 최근 위치 업데이트
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
