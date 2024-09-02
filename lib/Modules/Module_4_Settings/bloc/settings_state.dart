part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class SettingsDisplayLoadingState extends SettingsState {}

class SettingsDisplayFetchedState extends SettingsState {
  final bool statusBar;
  final String audioSource;
  final String recordingFormat;
  final String recordingFolder;
  final bool askForFilename;

  SettingsDisplayFetchedState({
    required this.statusBar,
    required this.audioSource,
    required this.recordingFormat,
    required this.recordingFolder,
    required this.askForFilename,
  });
}

class SettingsDisplayErrorState extends SettingsState {
  late final String errorMessage;
  SettingsDisplayErrorState({required this.errorMessage});
}

class SettingsUpdateLoadingState extends SettingsState {}

class SettingsUpdateSuccessState extends SettingsState {}

class SettingsUpdateErrorState extends SettingsState {
  late final String errorMessage;
  SettingsUpdateErrorState({required this.errorMessage});
}
