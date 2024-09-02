import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';

class RecorderTime extends StatelessWidget {
  final Duration recordingDuration;

  const RecorderTime({
    super.key,
    required this.recordingDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeUnit(
            recordingDuration.inHours.toString().padLeft(2, '0'), 'H', true),
        _buildTimeUnit(
            (recordingDuration.inMinutes % 60).toString().padLeft(2, '0'),
            'M',
            true),
        _buildTimeUnit(
            (recordingDuration.inSeconds % 60).toString().padLeft(2, '0'),
            'S',
            false),
      ],
    );
  }

  Widget _buildTimeUnit(String value, String unit, bool isBold) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 50,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w100,
            color: primaryRedColor,
          ),
        ),
        Text(
          unit,
          style: const TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryRedColor,
          ),
        ),
        if (unit != 'S') const SizedBox(width: 10),
      ],
    );
  }
}
