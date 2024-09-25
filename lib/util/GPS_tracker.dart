import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GPSTracker extends ChangeNotifier {
  double totalDistance = 0.0;
  Position? _previousPosition;

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
        totalDistance += Geolocator.distanceBetween(
          _previousPosition!.latitude,
          _previousPosition!.longitude,
          position.latitude,
          position.longitude,
        ) / 1000;
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
