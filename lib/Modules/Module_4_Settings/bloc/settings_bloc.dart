import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voice_recorder/services/local_storage_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {});

    on<SettingsDisplayFetchEvent>((event, emit) async {
      try {
        bool statusBar = await AppSettings.getStatusBar();
        String audioSource = await AppSettings.getAudioSource();
        String recordingFormat = await AppSettings.getRecordingFormat();
        String recordingFolder = await AppSettings.getRecordingFolder();
        bool askForFilename = await AppSettings.getAskForFilename();

        emit(SettingsDisplayFetchedState(
          statusBar: statusBar,
          audioSource: audioSource,
          recordingFormat: recordingFormat,
          recordingFolder: recordingFolder,
          askForFilename: askForFilename,
        ));
      } catch (e) {
        emit.call(SettingsDisplayErrorState(errorMessage: 'Error'));
      }
    });

    on<SettingsUpdateEvent>((event, emit) async {
      try {
        await AppSettings.saveStatusBar(event.statusBar);
        await AppSettings.saveAudioSource(event.audioSource);
        await AppSettings.saveRecordingFormat(event.recordingFormat);
        await AppSettings.saveRecordingFolder(event.recordingFolder);
        await AppSettings.saveAskForFilename(event.askForFilename);

        add(SettingsDisplayFetchEvent());
      } catch (e) {}
    });
  }
}
