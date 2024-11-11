import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'WeatherService.dart';

class WeatherInfoViewModel {
  final WeatherService weatherService;

  WeatherInfoViewModel(this.weatherService);

  double? windStrength;
  String? cityName;
  double? temperature;
  String? weatherDescription;

  Future<void> fetchWeatherInfo() async {
    PermissionStatus locationPermission = await weatherService.checkLocationPermission();

    if (locationPermission.isGranted) {
      Position position = await weatherService.getCurrentLocation();
      Map<String, dynamic> data = await weatherService.fetchWeatherData(position);

      cityName = data['name'];
      temperature = (data['main']['temp'] as num).toDouble();
      weatherDescription = data['weather'][0]['description'];
      windStrength = (data['wind']['speed'] as num).toDouble();
    } else {
      throw Exception("위치 권한이 거부되었습니다.");
    }
  }

  String getWindStrengthDescription() {
    if (windStrength != null) {
      if (windStrength! >= 5.0) {
        return "강풍";
      } else if (windStrength! >= 2.0) {
        return "약풍";
      } else {
        return "미풍";
      }
    }
    return "정보 없음";
  }
}