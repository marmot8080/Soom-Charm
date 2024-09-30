import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soom_charm/util/GPS_tracker.dart';
import 'package:soom_charm/widgets/on_off_button.dart';

class GPSTrackerScreen extends StatefulWidget {
  @override
  _GPSTrackerScreen createState() => _GPSTrackerScreen();
}

class _GPSTrackerScreen extends State<GPSTrackerScreen> {
  final GPSTracker _gpsTracker = GPSTracker();
  bool _isDialogVisible = false;

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
      appBar: AppBar(
        title: Text('GPS Tracker Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnOffButton(
              onToggle: _handleToggle,
            ),
            SizedBox(height: 20),
            Text(
              '${_gpsTracker.totalDistance.toStringAsFixed(2)} km',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
