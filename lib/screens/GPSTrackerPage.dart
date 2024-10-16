import 'package:flutter/material.dart';
import 'package:soom_charm/util/GPSTracker.dart';
import 'package:soom_charm/widgets/OnOffButton.dart';
import 'package:soom_charm/widgets/DistanceBar.dart';

class GPSTrackerPage extends StatefulWidget {
  @override
  _GPSTrackerPage createState() => _GPSTrackerPage();
}

class _GPSTrackerPage extends State<GPSTrackerPage> {
  final GPSTracker _gpsTracker = GPSTracker();
  bool _isDialogVisible = false;
  double _maxDistance = 3.0; // 포인트 획득 기준 거리

  @override
  void initState() {
    super.initState();
    _gpsTracker.addListener(() {
      setState(() {
        // 속도 30km/h 초과 시 다이얼로그 띄우기
        if (_gpsTracker.speedInKmh > 30) {
          if (_isDialogVisible == false) {
            _isDialogVisible = true;
            _showSpeedWarningDialog();
          }
        }
      }); // 거리 변화 시 상태 업데이트
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
  void dispose() {
    _gpsTracker.dispose(); // 리스너 제거
    super.dispose();
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
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 40)
                  ),
                ),
                SizedBox(height: 10),
                DistanceBar(
                    value: _gpsTracker.totalDistance % _maxDistance / _maxDistance
                ),
                Align(
                  alignment: Alignment.centerRight * 0.8,
                  child: Text(
                    '${(_gpsTracker.totalDistance % _maxDistance).toStringAsFixed(2)}/${_maxDistance.toStringAsFixed(0)}km',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                OnOffButton(
                  onToggle: _handleToggle,
                ),
                SizedBox(height: 30),
                Text(
                  '${_gpsTracker.totalDistance.toStringAsFixed(2)} km',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
          ),
      ),
    );
  }
}
