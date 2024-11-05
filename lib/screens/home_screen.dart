import 'package:flutter/material.dart';
import 'package:rainease_finalapp/constants/app_colors.dart';
import 'package:rainease_finalapp/widgets/temperature_display.dart';
import 'package:rainease_finalapp/widgets/weather_alert.dart';
import 'package:rainease_finalapp/widgets/control_pad.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TemperatureDisplay(),
                SizedBox(height: 20),
                WeatherAlert(),
                Spacer(),
                ControlPad(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
