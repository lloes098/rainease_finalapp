import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class WeatherAlert extends StatefulWidget {
  const WeatherAlert({super.key});

  @override
  State<WeatherAlert> createState() => _WeatherAlertState();
}

class _WeatherAlertState extends State<WeatherAlert> {
  String _message = '날씨 정보를 가져오는 중...';
  IconData _weatherIcon = Icons.cloud;
  Timer? _timer;
  
  // 송도과학로 85의 위도/경도
  final double lat = 37.3845;
  final double lon = 126.6568;

  @override
  void initState() {
    super.initState();
    _fetchWeatherCondition();
    // 5분마다 날씨 업데이트
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _fetchWeatherCondition();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchWeatherCondition() async {
    try {
      final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=58c1fc16b36988ddc012b3b20aca151c&units=metric'
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weatherId = data['weather'][0]['id'];
        final temp = data['main']['temp'].round();
        final windSpeed = data['wind']['speed'];

        setState(() {
          _updateWeatherInfo(weatherId, temp, windSpeed);
        });
      }
    } catch (e) {
      print('날씨 상태 가져오기 오류: $e');
    }
  }

  void _updateWeatherInfo(int weatherId, int temp, double windSpeed) {
    // 비 (200-531: 비/천둥)
    if ((weatherId >= 200 && weatherId <= 531)) {
      _message = '비가 오고 있습니다! 우산을 잊지 마세요.';
      _weatherIcon = Icons.umbrella;
    }
    // 눈 (600-622: 눈)
    else if (weatherId >= 600 && weatherId <= 622) {
      _message = '눈이 내리고 있어요! 따뜻하게 입고 조심히 이동하세요.';
      _weatherIcon = Icons.ac_unit;
    }
    // 강풍 (풍속 10m/s 이상)
    else if (windSpeed >= 10) {
      _message = '바람이 거세게 불고 있어요, 외출 시 따뜻하게 입으세요.';
      _weatherIcon = Icons.air;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.water_drop,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            '비가 오고 있습니다! 우산 챙기세요',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
