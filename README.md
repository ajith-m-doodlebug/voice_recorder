
# Voice Recorder

A versatile voice recording application built with Flutter. This app enables users to record audio in three different formats, save recordings, and play them back with ease. The user-friendly interface with unique colors and fonts, and visually centers waveform displays for a better experience.

## Features

The Voice Recorder app features three main screens, each with its own set of functionalities:

### 1. Recorder

![](https://github.com/user-attachments/assets/360227f8-8ba4-406d-a4d1-943b9f7f10bd)
![](https://github.com/user-attachments/assets/5983171f-fcc2-4075-9fd1-bf66a3eac61c)
![](https://github.com/user-attachments/assets/8421d5ca-d582-4411-a517-586df1ba29e0)
![](https://github.com/user-attachments/assets/b23c6022-2f51-4697-94f3-d81e953c78d9)

The **Recorder** screen is designed for capturing audio with various controls and features:
- **Pause and Stop**: Allows users to pause and stop recordings as needed.
- **Waveform Display**: Provides a visual representation of the audio being recorded, centered for optimal viewing.
- **Save Options**: Users can save recordings in one of three formats: M4A, MP3, or WAV.
- **File Naming**: Option to save recordings with or without a default file name.

### 2. Player

![](https://github.com/user-attachments/assets/7e431373-425f-4851-a8d5-7bae0073bc09)
![](https://github.com/user-attachments/assets/cdfc9d8a-20cf-4d1a-8424-59b89d79b2f3)


The **Player** screen offers playback functionality and detailed statistics:
- **Stats Overview**: Displays important information such as:
  - Total Recordings: The number of recordings saved.
  - Total Space: The amount of storage space used by recordings.
  - Total Time: The cumulative duration of all recordings.
- **Playback Interface**: Provides controls to play back recorded audio.

### 3. Settings

![](https://github.com/user-attachments/assets/16806132-2a97-42c2-9acd-cf831fffbc0f)
![](https://github.com/user-attachments/assets/33c19ce7-4e2f-4ae4-a2c5-e5a52d085357)

The **Settings** screen allows users to customize their app experience with the following options:
- **General Settings**:
  - **Status Bar**: Toggle the visibility of the status bar (Enable/Disable).
  - **Audio Source**: Choose the audio source from three options: Default, Microphone, or Bluetooth.
- **Advanced Settings**:
  - **Recording File Format**: Select from M4A, MP3, or WAV formats for recordings.
  - **Recording Folder**: Specify the folder where recordings will be saved.
  - **File Name Prompt**: Decide whether to prompt for a file name when saving recordings (Yes/No).


## Recording


https://github.com/user-attachments/assets/6c32f949-9bd7-489f-a728-486ef19dac83

## Getting Started

To set up and run the Voice Recorder app locally, follow these steps:

### 1. Clone the Repository

First, clone the repository to your local machine using Git:

```bash
git clone https://github.com/your-username/voice-recorder.git
```
    
### 2. Navigate to the Project Directory

Change into the project directory:

```bash
cd voice-recorder
```

### 3. Install Dependencies

Install the required Flutter dependencies:

```bash
flutter pub get
```

### 4. Run the Application

Start the application on your desired platform:

```bash
flutter run
```
## Dependencies

The Voice Recorder app uses the following dependencies:

### Core Packages

- **BLoC**: State management using BLoC architecture.
  - `bloc`: ^8.1.4
  - `flutter_bloc`: ^8.1.5

### Date and Time

- **intl**: For internationalization and localization.
  - `intl`: ^0.18.1

### Recording and Playback

- `record`: Handles audio recording capabilities.
- `just_audio`: Manages audio playback.

### Permissions and File Management

- `permission_handler`: Manages permissions for accessing device features.
- `path_provider`: Provides access to the file system paths.

### Storage and Sharing

- **shared_preferences**: Stores simple data persistently.
  - `shared_preferences`: ^2.2.3
- **share_plus**: Allows sharing of content from the app.
  - `share_plus`: ^4.1.0

Ensure you have these packages listed in your `pubspec.yaml` file for proper functionality of the app.




## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/). See the LICENSE file for details.

