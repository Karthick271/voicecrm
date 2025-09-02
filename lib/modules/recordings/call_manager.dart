import 'dart:io';
import 'package:phone_state/phone_state.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

 
import '../../utils/audio_utils.dart'; // for speakerphone hack

class CallManager {
  static final CallManager _instance = CallManager._internal();
  factory CallManager() => _instance;
  CallManager._internal() {
    _listenToPhoneState();
  }

  final AudioRecorder _recorder = AudioRecorder();
  String? _currentPath;
  String? _currentNumber;

  // 📞 Start listening to phone state
  void _listenToPhoneState() {
    PhoneState.stream.listen((event) async {
      try {
        if (event.status == PhoneStateStatus.CALL_STARTED) {
          _currentNumber = event.number ?? "unknown";
          print("📞 Call started with number: $_currentNumber");

          // enable speakerphone hack
          await AudioUtils.setSpeakerphone(true);

          // wait a second so audio route stabilizes
          await Future.delayed(const Duration(seconds: 1));

          _currentPath = await _startRecording(_currentNumber!);

        } else if (event.status == PhoneStateStatus.CALL_ENDED) {
          print("🛑 Call ended for number: $_currentNumber");

          final path = await _stopRecording();

          // disable speakerphone
          await AudioUtils.setSpeakerphone(false);

          if (path != null && _currentNumber != null) {
            await _uploadFile(path, _currentNumber!);
          }

          _currentNumber = null;
          _currentPath = null;
        }
      } catch (e, st) {
        print("⚠️ Error handling phone state: $e");
        print(st);
      }
    });
  }

  // 🎙️ Start recording
  Future<String?> _startRecording(String number) async {
    final dir = await getApplicationDocumentsDirectory();
    final now = DateTime.now().millisecondsSinceEpoch;
    final filePath = "${dir.path}/call_${number}_$now.m4a";

    if (await _recorder.hasPermission()) {
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
         bitRate: 192000,   // bump quality
    sampleRate: 48000, // bump quality
        ),
        path: filePath,
      );
      print("🎙️ Recording started: $filePath");
      return filePath;
    } else {
      print("❌ No microphone permission!");
      return null;
    }
  }

  // 🛑 Stop recording
  Future<String?> _stopRecording() async {
    final path = await _recorder.stop();
    if (path != null) {
      print("💾 Recording saved: $path");
    } else {
      print("⚠️ No recording file created.");
    }
    return path;
  }

  // ☁️ Upload to server
  Future<void> _uploadFile(String filePath, String number) async {
    try {
      final uri = Uri.parse("http://192.168.1.100:8000/api/call-logs"); 
      // ⚡ replace 192.168.1.100 with your laptop’s IP

      var request = http.MultipartRequest('POST', uri);

      // Security key header
      request.headers['X-API-KEY'] = "super-secret-key-123";

      request.fields['number'] = number;
      request.fields['timestamp'] = DateTime.now().toIso8601String();
      request.files.add(await http.MultipartFile.fromPath('recording', filePath));

      var response = await request.send();
      if (response.statusCode == 200) {
        print("✅ Uploaded successfully: $filePath");
      } else {
        print("❌ Upload failed (${response.statusCode}) for $filePath");
      }
    } catch (e) {
      print("⚠️ Upload error: $e");
    }
  }
}
