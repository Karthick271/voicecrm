import 'package:flutter/services.dart';

class AudioUtils {
  static const _platform = MethodChannel('voicecrm/audio');

  /// Enable or disable speakerphone
  static Future<void> setSpeakerphone(bool enabled) async {
    try {
      await _platform.invokeMethod('setSpeakerphoneOn', {"enabled": enabled});
      print("🔊 Speakerphone set to $enabled");
    } catch (e) {
      print("⚠️ Error toggling speakerphone: $e");
    }
  }
}
