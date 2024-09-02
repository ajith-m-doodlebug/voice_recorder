import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_recorder/Modules/Module_4_Settings/UI/settings_checkbox_item.dart';
import 'package:voice_recorder/Modules/Module_4_Settings/UI/settings_system_data.dart';
import 'package:voice_recorder/Modules/Module_4_Settings/UI/settings_tap_item.dart';
import 'package:voice_recorder/Modules/Module_4_Settings/bloc/settings_bloc.dart';
import 'package:voice_recorder/Utils/colors.dart';
import 'package:voice_recorder/Utils/names_of_fonts.dart';
import 'package:voice_recorder/Utils/ui_sizes.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(SettingsDisplayFetchEvent()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsDisplayLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: primaryRedColor),
            );
          }

          if (state is SettingsDisplayFetchedState) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceRegular,

                    // General
                    const Text(
                      'General',
                      style: TextStyle(
                        fontFamily: jakartaSansFont,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryRedColor,
                      ),
                    ),
                    verticalSpaceRegular,

                    // General - Items
                    SettingsCheckBoxItem(
                      name: 'Status bar',
                      detail: state.statusBar ? 'Enabled' : 'Disabled',
                      initialChecked: state.statusBar,
                      onChanged: (bool? value) {
                        context.read<SettingsBloc>().add(
                              SettingsUpdateEvent(
                                statusBar: value ?? true,
                                audioSource: state.audioSource,
                                recordingFormat: state.recordingFormat,
                                recordingFolder: state.recordingFolder,
                                askForFilename: state.askForFilename,
                              ),
                            );
                      },
                    ),
                    verticalSpaceRegular,

                    SettingsTapItem(
                      name: 'Audio Source',
                      detail: state.audioSource,
                      options: getAvailableAudioSources(),
                      onSelected: (String? value) {
                        context.read<SettingsBloc>().add(
                              SettingsUpdateEvent(
                                statusBar: state.statusBar,
                                audioSource: value ?? state.audioSource,
                                recordingFormat: state.recordingFormat,
                                recordingFolder: state.recordingFolder,
                                askForFilename: state.askForFilename,
                              ),
                            );
                      },
                    ),
                    verticalSpaceRegular,

                    // Advanced
                    const Text(
                      'Advanced',
                      style: TextStyle(
                        fontFamily: jakartaSansFont,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryRedColor,
                      ),
                    ),
                    verticalSpaceRegular,

                    SettingsTapItem(
                      name: 'Recording Format',
                      detail: state.recordingFormat,
                      options: getAvailableRecordingFormats(),
                      onSelected: (String? value) {
                        context.read<SettingsBloc>().add(
                              SettingsUpdateEvent(
                                statusBar: state.statusBar,
                                audioSource: state.audioSource,
                                recordingFormat: value ?? state.recordingFormat,
                                recordingFolder: state.recordingFolder,
                                askForFilename: state.askForFilename,
                              ),
                            );
                      },
                    ),

                    verticalSpaceRegular,

                    SettingsTapItem(
                      name: 'Recording Folder',
                      detail: state.recordingFolder,
                      options: getAvailableRecordingFolders(),
                      onSelected: (String? value) {
                        context.read<SettingsBloc>().add(
                              SettingsUpdateEvent(
                                statusBar: state.statusBar,
                                audioSource: state.audioSource,
                                recordingFormat: state.recordingFormat,
                                recordingFolder: value ?? state.recordingFolder,
                                askForFilename: state.askForFilename,
                              ),
                            );
                      },
                    ),
                    verticalSpaceRegular,

                    SettingsCheckBoxItem(
                      name: 'Ask for Filename',
                      detail: state.askForFilename ? 'Yes' : 'No',
                      initialChecked: state.askForFilename,
                      onChanged: (bool? value) {
                        context.read<SettingsBloc>().add(
                              SettingsUpdateEvent(
                                statusBar: state.statusBar,
                                audioSource: state.audioSource,
                                recordingFormat: state.recordingFormat,
                                recordingFolder: state.recordingFolder,
                                askForFilename: value ?? true,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is SettingsDisplayErrorState) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  fontFamily: jakartaSansFont,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: greyColor,
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
