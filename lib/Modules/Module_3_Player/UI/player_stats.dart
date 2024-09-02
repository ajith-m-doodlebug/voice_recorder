import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';

class PlayerStats extends StatelessWidget {
  final int totalFiles;
  final String totalDurationFormatted;
  final String totalSizeFormatted;

  const PlayerStats({
    super.key,
    required this.totalFiles,
    required this.totalDurationFormatted,
    required this.totalSizeFormatted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$totalFiles Recordings',
          style: const TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          '•',
          style: TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          totalDurationFormatted,
          style: const TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          '•',
          style: TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          totalSizeFormatted,
          style: const TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
