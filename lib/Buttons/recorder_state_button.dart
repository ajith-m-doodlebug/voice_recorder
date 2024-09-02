import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/colors.dart';

class RecorderStateButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const RecorderStateButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: primaryRedColor,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(5),
      child: IconButton(
        iconSize: 25,
        icon: Icon(
          icon,
          color: whiteColor,
        ),
        onPressed: onTap,
      ),
    );
  }
}
