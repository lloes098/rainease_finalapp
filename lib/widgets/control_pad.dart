import 'package:flutter/material.dart';

class ControlPad extends StatelessWidget {
  const ControlPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildDirectionButton(Icons.keyboard_arrow_up),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDirectionButton(Icons.keyboard_arrow_left),
              _buildPowerButton(),
              _buildDirectionButton(Icons.keyboard_arrow_right),
            ],
          ),
          _buildDirectionButton(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildDirectionButton(IconData icon) {
    return Icon(
      icon,
      color: Colors.white,
      size: 40,
    );
  }

  Widget _buildPowerButton() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.power_settings_new,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
