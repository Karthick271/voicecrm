// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:record/record.dart';

// class CallRecorder {
//   final AudioRecorder _recorder = AudioRecorder();

//   Future<String> _getFilePath() async {
//     final dir = await getApplicationDocumentsDirectory();
//     return '${dir.path}/call_${DateTime.now().millisecondsSinceEpoch}.m4a';
//   }

//   Future<String?> startRecording() async {
//     if (await _recorder.hasPermission()) {
//       String path = await _getFilePath();
//       await _recorder.start(
//         const RecordConfig(encoder: AudioEncoder.aacLc), // MP4/AAC
//         path: path,
//       );
//       return path;
//     }
//     return null;
//   }

//   Future<void> stopRecording() async {
//     await _recorder.stop();
//   }
// }
