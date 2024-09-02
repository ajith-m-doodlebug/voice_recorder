import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_recorder/Buttons/recorder_state_button.dart';
import 'package:voice_recorder/Enums/recorder_state_enum.dart';
import 'package:voice_recorder/HelperWidgets/alerts_dialogs.dart';
import 'package:voice_recorder/HelperWidgets/snack_bar.dart';
import 'package:voice_recorder/Modules/Module_2_Recorder/UI/recorder_time.dart';
import 'package:voice_recorder/Modules/Module_2_Recorder/UI/recorder_wave_painter.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';
import 'package:voice_recorder/Utils/ui_sizes.dart';
import 'package:voice_recorder/services/local_storage_service.dart';

class Recorder extends StatefulWidget {
  const Recorder({super.key});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  final _record = AudioRecorder();
  RecorderStateEnum _recorderState = RecorderStateEnum.idle;
  StreamSubscription? _timerSubscription;
  Duration _recordingDuration = Duration.zero;
  double _currentAmplitude = 0.0;

  List<double> _amplitudeSamples = [];
  late String _fileExtension;
  late bool _askForFilename;

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    final format = await AppSettings.getRecordingFormat();
    final filename = await AppSettings.getAskForFilename();

    setState(() {
      _fileExtension = format.toLowerCase();
      _askForFilename = filename;
    });
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    _record.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (await _requestPermission()) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/temp.$_fileExtension';

      await _record.start(
        const RecordConfig(),
        path: filePath,
      );
      setState(() {
        _recorderState = RecorderStateEnum.recording;
      });

      _startTimer();
    } else {
      await _requestPermission();
    }
  }

  Future<void> _stopRecording() async {
    if (_recorderState == RecorderStateEnum.recording ||
        _recorderState == RecorderStateEnum.paused) {
      final alerts = AlertsDialogs();

      final now = DateTime.now();

      final dayFormat = DateFormat('EEEE');
      final timeFormat = DateFormat('h:mm a');
      final defaultFileName =
          '${dayFormat.format(now)} at ${timeFormat.format(now)}';

      if (_askForFilename) {
        alerts.showFileNameDialog(
          context,
          title: 'Save Recording',
          initialFileName: defaultFileName,
          onFileNameEntered: (fileName) async {
            _saveFile(fileName);
          },
        );
      } else {
        _saveFile(defaultFileName);
      }
    }
  }

  Future<void> _saveFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final newFilePath = '${directory.path}/$fileName.$_fileExtension';

    await _record.stop();
    await _moveFile('${directory.path}/temp.$_fileExtension', newFilePath);

    setState(() {
      _recorderState = RecorderStateEnum.idle;
      _recordingDuration = Duration.zero;
      _currentAmplitude = 0.0;
      _amplitudeSamples.clear();
    });

    _timerSubscription?.cancel();

    // ignore: use_build_context_synchronously
    SnackBarHelper(context).showSuccessSnackBar("Audio Saved");
  }

  Future<void> _pauseRecording() async {
    if (_recorderState == RecorderStateEnum.recording) {
      await _record.pause();
      setState(() {
        _recorderState = RecorderStateEnum.paused;
        _timerSubscription?.pause();
      });
    }
  }

  Future<void> _resumeRecording() async {
    if (_recorderState == RecorderStateEnum.paused) {
      await _record.resume();
      setState(() {
        _recorderState = RecorderStateEnum.recording;
        _startTimer();
      });
    }
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  void _startTimer() {
    _timerSubscription =
        Stream.periodic(const Duration(milliseconds: 100)).listen((_) async {
      setState(() {
        _recordingDuration =
            _recordingDuration + const Duration(milliseconds: 100);
      });

      final amplitude = await _record.getAmplitude();
      setState(() {
        _currentAmplitude = (amplitude.current / amplitude.max);
        final roundedAmplitude = double.parse(
          _currentAmplitude.toStringAsFixed(3),
        );

        _amplitudeSamples.add(roundedAmplitude);
      });
    });
  }

  Future<void> _moveFile(String oldPath, String newPath) async {
    final oldFile = File(oldPath);
    final newFile = File(newPath);

    if (await oldFile.exists()) {
      if (await newFile.exists()) {
        await newFile.delete();
      }

      await oldFile.rename(newPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Time
        RecorderTime(
          recordingDuration: _recordingDuration,
        ),
        verticalSpaceRegular,

        // Text for state
        Text(
          _recorderState == RecorderStateEnum.idle
              ? 'Tap the button to start a new recording.'
              : _recorderState == RecorderStateEnum.recording
                  ? 'Recording is in progress.'
                  : _recorderState == RecorderStateEnum.paused
                      ? 'Recording is paused.'
                      : '',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: jakartaSansFont,
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: greyColor,
          ),
        ),
        verticalSpaceMedium,

        // Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _recorderState == RecorderStateEnum.idle,
              child:
                  RecorderStateButton(icon: Icons.mic, onTap: _startRecording),
            ),
            Visibility(
              visible: _recorderState == RecorderStateEnum.recording,
              child: RecorderStateButton(
                  icon: Icons.pause, onTap: _pauseRecording),
            ),
            Visibility(
              visible: _recorderState == RecorderStateEnum.paused,
              child: RecorderStateButton(
                  icon: Icons.play_arrow, onTap: _resumeRecording),
            ),
            Visibility(
              visible: _recorderState == RecorderStateEnum.recording ||
                  _recorderState == RecorderStateEnum.paused,
              child:
                  RecorderStateButton(icon: Icons.stop, onTap: _stopRecording),
            ),
          ],
        ),
        verticalSpaceMedium,

        // Waves
        Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomPaint(
            painter: WaveformPainter(
              amplitudes: _amplitudeSamples,
            ),
          ),
        ),
      ],
    );
  }
}
