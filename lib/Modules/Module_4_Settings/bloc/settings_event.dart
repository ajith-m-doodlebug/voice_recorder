part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class SettingsDisplayFetchEvent extends SettingsEvent {}

class SettingsUpdateEvent extends SettingsEvent {
  final bool statusBar;
  final String audioSource;
  final String recordingFormat;
  final String recordingFolder;
  final bool askForFilename;

  SettingsUpdateEvent({
    required this.statusBar,
    required this.audioSource,
    required this.recordingFormat,
    required this.recordingFolder,
    required this.askForFilename,
  });
}
