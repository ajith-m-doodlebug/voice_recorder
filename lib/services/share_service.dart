import 'dart:io';

import 'package:share_plus/share_plus.dart';

class ShareService {
  void shareText(String text) {
    Share.share(text);
  }

  void shareAudio(String filePath) {
    final file = File(filePath);
    if (file.existsSync()) {
      Share.shareFiles([filePath], text: 'Check out this audio!');
    }
  }
}
