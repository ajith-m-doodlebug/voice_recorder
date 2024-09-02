import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:voice_recorder/Modules/Module_3_Player/UI/player_item.dart';
import 'package:voice_recorder/Modules/Module_3_Player/UI/player_slider.dart';
import 'package:voice_recorder/Modules/Module_3_Player/UI/player_stats.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  List<FileSystemEntity> _files = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _playingIndex;
  bool _isPlayerVisible = false;
  int _totalFileSize = 0;
  Duration _totalDuration = Duration.zero;
  bool _isCalculating = true;

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory
        .listSync()
        .where((file) =>
            ['.mp3', '.wav', '.m4a'].any((ext) => file.path.endsWith(ext)))
        .toList();

    if (mounted) {
      setState(() {
        _files = files.reversed.toList();
      });
    }

    await _calculateFileStats();
  }

  Future<void> _calculateFileStats() async {
    if (mounted) {
      setState(() {
        _isCalculating = true;
      });
    }

    final directory = await getApplicationDocumentsDirectory();
    final filePaths = directory
        .listSync()
        .where((file) =>
            ['.mp3', '.wav', '.m4a'].any((ext) => file.path.endsWith(ext)))
        .map((file) => file.path)
        .toList();

    int totalSize = 0;
    Duration totalDuration = Duration.zero;

    for (var path in filePaths) {
      final audioFile = File(path);
      totalSize += audioFile.lengthSync();

      final audioPlayer = AudioPlayer();
      await audioPlayer.setFilePath(path);
      final duration = await audioPlayer.load();
      totalDuration += duration ?? Duration.zero;
      audioPlayer.dispose();
    }

    if (mounted) {
      setState(() {
        _totalFileSize = totalSize;
        _totalDuration = totalDuration;
        _isCalculating = false;
      });
    }
  }

  Future<void> _playAudio(String path, int index) async {
    setState(() {
      _playingIndex = index;
      _isPlayerVisible = true;
    });
    await _audioPlayer.setFilePath(path);
    await _audioPlayer.play();
  }

  void _stopAudio() {
    _audioPlayer.stop();
    setState(() {
      _playingIndex = null;
      _isPlayerVisible = false;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _formatFileSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    final totalFiles = _files.length;
    final totalSizeFormatted = _formatFileSize(_totalFileSize);
    final totalDurationFormatted = _formatDuration(_totalDuration);

    return Column(
      children: [
        // Player Stats
        Container(
          padding: const EdgeInsets.all(16),
          child: _isCalculating
              ? const SizedBox()
              : PlayerStats(
                  totalFiles: totalFiles,
                  totalDurationFormatted: totalDurationFormatted,
                  totalSizeFormatted: totalSizeFormatted,
                ),
        ),

        // Player List
        Expanded(
          child: _files.isEmpty
              ? const Center(
                  child: Text(
                    'No audio files found.',
                    style: TextStyle(
                      fontFamily: jakartaSansFont,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: greyColor,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _files.length,
                  itemBuilder: (context, index) {
                    return PlayerItem(
                      file: _files[index] as File,
                      index: index,
                      playingIndex: _playingIndex,
                      onPlay: _playAudio,
                      onStop: _stopAudio,
                      formatFileSize: _formatFileSize,
                    );
                  },
                ),
        ),

        // Player Slider
        Visibility(
          visible: _isPlayerVisible,
          child: PlayerSlider(
            positionStream: _audioPlayer.positionStream,
            durationStream: _audioPlayer.durationStream,
            onSeek: (duration) {
              _audioPlayer.seek(duration);
            },
            onPlay: () {
              _audioPlayer.play();
              setState(() {});
            },
            onPause: () {
              _audioPlayer.pause();
              setState(() {});
            },
            onStop: _stopAudio,
            isPlaying: _audioPlayer.playing,
          ),
        ),
      ],
    );
  }
}
