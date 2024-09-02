import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';
import 'package:voice_recorder/Utils/ui_sizes.dart';

class SettingsCheckBoxItem extends StatefulWidget {
  final String name;
  final String detail;
  final bool initialChecked;
  final ValueChanged<bool>? onChanged;

  const SettingsCheckBoxItem({
    super.key,
    required this.name,
    required this.detail,
    required this.initialChecked,
    this.onChanged,
  });

  @override
  _SettingsCheckBoxItemState createState() => _SettingsCheckBoxItemState();
}

class _SettingsCheckBoxItemState extends State<SettingsCheckBoxItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialChecked;
  }

  void _onChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  widget.name,
                  style: const TextStyle(
                    fontFamily: jakartaSansFont,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: headingBlackColor,
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  widget.detail,
                  style: const TextStyle(
                    fontFamily: jakartaSansFont,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: greyColor,
                  ),
                ),
              ],
            ),
          ),
          // Checkbox
          Checkbox(
            value: isChecked,
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }
}
