import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/colors.dart';

class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  final double barSpacing; // Space between bars

  WaveformPainter({required this.amplitudes, this.barSpacing = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = primaryRedColor
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    if (amplitudes.isEmpty) return;

    final int barCount = amplitudes.length;
    final double barWidth = 3.0; // Fixed bar width
    final double totalWidth = barCount * (barWidth + barSpacing);
    final double startX =
        (width - totalWidth) / 2; // Start drawing from the center

    // Normalize amplitudes to the range of 0 to 1
    final double maxAmplitude = amplitudes.reduce((a, b) => a > b ? a : b);
    final List<double> normalizedAmplitudes =
        amplitudes.map((amplitude) => amplitude / maxAmplitude).toList();

    final double amplitudeScale =
        height / 2; // Scaling to fit within half the height

    final Radius cornerRadius =
        Radius.circular(4.0); // Radius for rounded corners

    for (int i = 0; i < barCount; i++) {
      final double amplitude = normalizedAmplitudes[i];
      final double left = startX + i * (barWidth + barSpacing);
      final double top = height / 2 - (amplitude * amplitudeScale);
      final double right = left + barWidth;
      final double bottom = height / 2 + (amplitude * amplitudeScale);

      final RRect barRRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(left, top, right, bottom),
        cornerRadius,
      );

      canvas.drawRRect(barRRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
