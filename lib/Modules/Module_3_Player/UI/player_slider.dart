import 'package:flutter/material.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';

class PlayerSlider extends StatelessWidget {
  final Stream<Duration?> positionStream;
  final Stream<Duration?> durationStream;
  final void Function(Duration) onSeek;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onStop;
  final bool isPlaying;

  const PlayerSlider({
    super.key,
    required this.positionStream,
    required this.durationStream,
    required this.onSeek,
    required this.onPlay,
    required this.onPause,
    required this.onStop,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: positionStream,
      builder: (context, positionSnapshot) {
        final position = positionSnapshot.data ?? Duration.zero;
        return StreamBuilder<Duration?>(
          stream: durationStream,
          builder: (context, durationSnapshot) {
            final duration = durationSnapshot.data ?? Duration.zero;
            return Column(
              children: [
                Slider(
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    onSeek(Duration(seconds: value.toInt()));
                  },
                  activeColor: primaryRedColor,
                  inactiveColor: mediumGreyColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(position),
                        style: const TextStyle(
                          fontFamily: jakartaSansFont,
                          color: greyColor,
                        ),
                      ),
                      Text(
                        _formatDuration(duration),
                        style: const TextStyle(
                          fontFamily: jakartaSansFont,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 50,
                        color: primaryRedColor,
                        onPressed: isPlaying ? onPause : onPlay,
                      ),
                      IconButton(
                        icon: const Icon(Icons.stop),
                        color: primaryRedColor,
                        iconSize: 50,
                        onPressed: onStop,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
