import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 패키지 추가
import 'package:soom_charm/util/GPS_tracker.dart';
import 'package:soom_charm/widgets/on_off_button.dart';

class GPSTrackerScreen extends StatefulWidget {
  @override
  _GPSTrackerScreen createState() => _GPSTrackerScreen();
}

class _GPSTrackerScreen extends State<GPSTrackerScreen> {
  final GPSTracker _gpsTracker = GPSTracker();

  @override
  void initState() {
    super.initState();
    _gpsTracker.addListener(() {
      setState(() {}); // 거리 변화 시 상태 업데이트
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
