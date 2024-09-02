import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/colors.dart';

class SettingsTapItem extends StatelessWidget {
  final String name;
  final String detail;
  final List<String> options;
  final ValueChanged<String>? onSelected;

  const SettingsTapItem({
    super.key,
    required this.name,
    required this.detail,
    required this.options,
    this.onSelected,
  });

  void _showOptionsDialog(BuildContext context) async {
    final selectedOption = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: SingleChildScrollView(
            child: ListBody(
              children: options.map((option) {
                return ListTile(
                  title: Text(option),
                  onTap: () {
                    Navigator.of(context).pop(option);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedOption != null && onSelected != null) {
      onSelected!(selectedOption);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showOptionsDialog(context),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: mediumGreyColor,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Name and detail section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily:
                          'JakartaSans', // Replace with your font family
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Replace with your color
                    ),
                  ),
                  const SizedBox(height: 4), // Replace with your spacing
                  Text(
                    detail,
                    style: const TextStyle(
                      fontFamily:
                          'JakartaSans', // Replace with your font family
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey, // Replace with your color
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_drop_down), // Indicating a dropdown
          ],
        ),
      ),
    );
  }
}
