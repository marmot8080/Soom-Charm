import 'package:flutter/material.dart';
import 'package:soom_charm/util/GPSTracker.dart';
import 'package:soom_charm/util/SharedPreferenceManager.dart';

import 'package:soom_charm/widgets/OnOffButton.dart';
import 'package:soom_charm/widgets/DistanceBar.dart';

class GPSTrackerPage extends StatefulWidget {
  @override
  _GPSTrackerPage createState() => _GPSTrackerPage();
}

class _GPSTrackerPage extends State<GPSTrackerPage> {
  late GPSTracker _gpsTracker;
  final double _speedLimit = 30; // 제한 속도
  final double _maxDistance = 1.0; // 포인트 획득 기준 거리
  final int _pointPerDistance = 100; // _maxDistance 달성 시 마다 획득 포인트
  late SharedPreferenceManager spManager;
  late double? _totalDistance;
  late int? _point;
  late int _tmp;
  bool _isDialogVisible = false;

  @override
  void initState() {
    super.initState();

    _initializePointCount();
    _initializeTotalDistance();

  }

  @override
  void dispose() {
    spManager.setTotalDistance(_totalDistance!);
    _gpsTracker.dispose(); // 리스너 제거
    super.dispose();
  }

  void _initializeTotalDistance() async {
    spManager = SharedPreferenceManager();
    spManager.initInstance(); // 인스턴스 초기화

    _totalDistance = await spManager.getTotalDistance(); // 비동기 호출
    setState(() {
      _totalDistance = _totalDistance ?? 0;
    });

    _tmp = _totalDistance! ~/ _maxDistance;

    _gpsTracker = GPSTracker(totalDistance: _totalDistance!);
    _gpsTracker.addListener(() {
      setState(() {
        // 제한 속도 초과 시 다이얼로그 띄우기
        if (_gpsTracker.speedInKmh > _speedLimit) {
          if (_isDialogVisible == false) {
            _isDialogVisible = true;
            _showSpeedWarningDialog();
          }
        }

        // _maxDistance 달성 시 마다 포인트 부여
        if(_totalDistance! ~/ _maxDistance == _tmp + 1) {
          _tmp += 1;
          _point = _point! + _pointPerDistance;
          spManager.setPoint(_point!);
        }
      }); // 거리 변화 시 상태 업데이트
    });
  }

  void _initializePointCount() async {
    spManager = SharedPreferenceManager();
    spManager.initInstance(); // 인스턴스 초기화

    _point = await spManager.getPoint(); // 비동기 호출
    setState(() {
      _point = _point ?? 0;
    });
  }

  void _handleToggle(bool isOn) async {
    if (isOn) {
      try {
        await _gpsTracker.startTracking();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      _gpsTracker.stopTracking();
    }
  }

  void _showSpeedWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '속도초과',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  '속도가 너무 빠릅니다.\n좀 더 천천히 걸으세요.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _isDialogVisible = false;
                    },
                    child: Text('확인'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6CB7FF),
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft * 0.9,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        },
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: MediaQuery.of(context).size.height * 0.035)
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                DistanceBar(
                    value: _totalDistance! % _maxDistance / _maxDistance
                ),
                Align(
                  alignment: Alignment.centerRight * 0.85,
                  child: Text(
                    '${(_totalDistance! % _maxDistance).toStringAsFixed(2)}/${_maxDistance.toStringAsFixed(0)}km',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                OnOffButton(
                  onToggle: _handleToggle,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text(
                  '${_totalDistance!.toStringAsFixed(2)} km',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
          ),
      ),
    );
  }
}
