import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';

class AlertsDialogs {
  // Existing method for showing a confirmation dialog
  void showAccountDialog(
    BuildContext context, {
    required String heading,
    required String subheading,
    required Function() onYesPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            heading,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: jakartaSansFont,
              fontWeight: FontWeight.bold,
              color: headingBlackColor,
            ),
          ),
          content: Text(
            subheading,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: jakartaSansFont,
              fontWeight: FontWeight.w400,
              color: greyColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: jakartaSansFont,
                  fontWeight: FontWeight.bold,
                  color: headingBlackColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onYesPressed();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: jakartaSansFont,
                  fontWeight: FontWeight.bold,
                  color: headingBlackColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Updated method for showing a dialog with a text field for input
  void showFileNameDialog(
    BuildContext context, {
    required String title,
    required Function(String fileName) onFileNameEntered,
    String initialFileName = '', // New parameter for initial file name
  }) {
    final TextEditingController _controller =
        TextEditingController(text: initialFileName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: jakartaSansFont,
              fontWeight: FontWeight.bold,
              color: headingBlackColor,
            ),
          ),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter file name',
              hintStyle: TextStyle(
                color: greyColor,
                fontFamily: jakartaSansFont,
              ),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: jakartaSansFont,
                  fontWeight: FontWeight.bold,
                  color: headingBlackColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final fileName = _controller.text.trim();
                if (fileName.isNotEmpty) {
                  onFileNameEntered(fileName);
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: jakartaSansFont,
                  fontWeight: FontWeight.bold,
                  color: headingBlackColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
