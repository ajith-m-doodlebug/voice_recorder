import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static const _statusBarKey = 'status_bar';
  static const _audioSourceKey = 'audio_source';
  static const _recordingFormatKey = 'recording_format';
  static const _recordingFolderKey = 'recording_folder';
  static const _askForFilenameKey = 'ask_for_filename';

  static const _defaultStatusBar = true;
  static const _defaultAudioSource = 'Default';
  static const _defaultRecordingFormat = 'M4A';
  static const _defaultRecordingFolder = 'App Storage';
  static const _defaultAskForFilename = true;

  // Save settings
  static Future<void> saveStatusBar(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_statusBarKey, value);
  }

  static Future<void> saveAudioSource(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_audioSourceKey, value);
  }

  static Future<void> saveRecordingFormat(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_recordingFormatKey, value);
  }

  static Future<void> saveRecordingFolder(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_recordingFolderKey, value);
  }

  static Future<void> saveAskForFilename(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_askForFilenameKey, value);
  }

  // Retrieve settings with default values
  static Future<bool> getStatusBar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_statusBarKey) ?? _defaultStatusBar;
  }

  static Future<String> getAudioSource() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_audioSourceKey) ?? _defaultAudioSource;
  }

  static Future<String> getRecordingFormat() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_recordingFormatKey) ?? _defaultRecordingFormat;
  }

  static Future<String> getRecordingFolder() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_recordingFolderKey) ?? _defaultRecordingFolder;
  }

  static Future<bool> getAskForFilename() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_askForFilenameKey) ?? _defaultAskForFilename;
  }
}
