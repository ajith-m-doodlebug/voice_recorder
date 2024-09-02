import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voice_recorder/HelperWidgets/snack_bar.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';
import 'package:voice_recorder/Utils/ui_sizes.dart';
import 'package:voice_recorder/services/share_service.dart';

class PlayerItem extends StatelessWidget {
  final File file;
  final int index;
  final int? playingIndex;
  final Function(String, int) onPlay;
  final Function() onStop;
  final String Function(int) formatFileSize;

  const PlayerItem({
    Key? key,
    required this.file,
    required this.index,
    required this.playingIndex,
    required this.onPlay,
    required this.onStop,
    required this.formatFileSize,
  }) : super(key: key);

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today, ${DateFormat('h:mm a').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${DateFormat('h:mm a').format(date)}';
    } else {
      return DateFormat('EEE, MMM d, yyyy, h:mm a').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file.uri.pathSegments.last;
    final fileNameWithoutExtension = fileName.split('.').first;
    final fileExtension = fileName.split('.').last;
    final fileStats = file.statSync();
    final creationDate = fileStats.changed;
    final fileSize = fileStats.size;

    final isPlaying = playingIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          if (isPlaying) {
            onStop();
          } else {
            if (file.existsSync()) {
              onPlay(file.path, index);
            } else {
              SnackBarHelper(context).showSuccessSnackBar("File not found");
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            border: isPlaying ? Border.all(color: Colors.red, width: 2) : null,
            boxShadow: const [
              BoxShadow(
                color: mediumGreyColor,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileNameWithoutExtension,
                        style: const TextStyle(
                          fontFamily: jakartaSansFont,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        formatDate(creationDate),
                        style: const TextStyle(
                          fontFamily: jakartaSansFont,
                          fontSize: 14,
                          color: greyColor,
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        '$fileExtension • ${formatFileSize(fileSize)}',
                        style: const TextStyle(
                          fontFamily: jakartaSansFont,
                          fontSize: 14,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.share,
                    color: primaryRedColor,
                    size: 25,
                  ),
                  onPressed: () {
                    ShareService().shareText(file.path);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
