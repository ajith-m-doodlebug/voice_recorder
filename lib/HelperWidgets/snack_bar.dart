import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';

class SnackBarHelper {
  final BuildContext context;

  SnackBarHelper(this.context);

  void showSuccessSnackBar(String message) {
    _showSnackBar(message, greyColor);
  }

  void showErrorSnackBar(String message) {
    _showSnackBar(message, greyColor);
  }

  void showInfoSnackBar(String message) {
    _showSnackBar(message, greyColor);
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: jakartaSansFont,
            fontWeight: FontWeight.w400,
            color: whiteColor,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
