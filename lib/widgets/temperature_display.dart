import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TemperatureDisplay extends StatefulWidget {
  const TemperatureDisplay({super.key});

  @override
  State<TemperatureDisplay> createState() => _TemperatureDisplayState();
}

class _TemperatureDisplayState extends State<TemperatureDisplay> {
  String _temperature = '--';
  final String _address = '인천광역시 연수구 송도과학로 85';
  Timer? _timer;
  
  // 송도과학로 85의 위도/경도
  final double lat = 37.3845;
  final double lon = 126.6568;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    // 5분마다 날씨 업데이트
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _fetchWeather();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=58c1fc16b36988ddc012b3b20aca151c&units=metric'
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _temperature = '${data['main']['temp'].round()}°';
        });
        print('날씨 업데이트: $_temperature'); // 디버깅용
      } else {
        print('날씨 API 오류: ${response.statusCode}'); // 디버깅용
        setState(() {
          _temperature = '--°';
        });
      }
    } catch (e) {
      print('날씨 가져오기 오류: $e'); // 디버깅용
      setState(() {
        _temperature = '--°';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _temperature,
          style: const TextStyle(
            fontSize: 80,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                _address,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.location_on,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ],
    );
  }
}
