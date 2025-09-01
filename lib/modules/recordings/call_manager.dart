import 'dart:io';
import 'package:phone_state/phone_state.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class CallManager {
  static final CallManager _instance = CallManager._internal();
  factory CallManager() => _instance;
  CallManager._internal() {
    _listenToPhoneState();
  }

  final AudioRecorder _recorder = AudioRecorder();
  String? _currentPath;
  String? _currentNumber;

  // Start listening to phone events
  void _listenToPhoneState() {
    PhoneState.stream.listen((event) async {
      if (event.status == PhoneStateStatus.CALL_STARTED) {
        _currentNumber = event.number ?? "unknown";
        _currentPath = await _startRecording(_currentNumber!);
      } else if (event.status == PhoneStateStatus.CALL_ENDED) {
        final path = await _stopRecording();
        if (path != null && _currentNumber != null) {
          await _uploadFile(path, _currentNumber!);
        }
        _currentNumber = null;
        _currentPath = null;
      }
    });
  }

  Future<String?> _startRecording(String number) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/call_${number}_${DateTime.now().millisecondsSinceEpoch}.m4a";

    if (await _recorder.hasPermission()) {
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
        path: filePath,
      );
      print("🎙️ Recording started: $filePath");
      return filePath;
    }
    return null;
  }

  Future<String?> _stopRecording() async {
    final path = await _recorder.stop();
    if (path != null) print("💾 Recording saved: $path");
    return path;
  }
Future<void> _uploadFile(String filePath, String number) async {
  try {
    // ⚡ local FastAPI server
    var uri = Uri.parse("http://192.168.1.100:8000/api/call-logs");  
    // 🔑 replace 192.168.1.100 with your PC’s local IP (not 127.0.0.1)

    var request = http.MultipartRequest('POST', uri);

    // ✅ Security key (must match FastAPI server)
    request.headers['X-API-KEY'] = "super-secret-key-123";

    request.fields['number'] = number;
    request.fields['timestamp'] = DateTime.now().toIso8601String();
    request.files.add(await http.MultipartFile.fromPath('recording', filePath));

    var response = await request.send();
    if (response.statusCode == 200) {
      print("✅ Uploaded successfully to server");
    } else {
      print("❌ Upload failed: ${response.statusCode}");
    }
  } catch (e) {
    print("⚠️ Upload error: $e");
  }
}

}
