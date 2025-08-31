// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:record/record.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class RecordNoteScreen extends StatefulWidget {
//   final String contactName;

//   const RecordNoteScreen({super.key, required this.contactName});

//   @override
//   State<RecordNoteScreen> createState() => _RecordNoteScreenState();
// }

// class _RecordNoteScreenState extends State<RecordNoteScreen> {
//   late final Record _recorder;
//   bool _isRecording = false;
//   String? _filePath;

//   @override
//   void initState() {
//     super.initState();
//     _recorder = Record();
//   }

//   Future<void> _startRecording() async {
//     final status = await Permission.microphone.request();
//     if (status.isGranted && await _recorder.hasPermission()) {
//       final dir = await getApplicationDocumentsDirectory();
//       final path = '${dir.path}/note_${DateTime.now().millisecondsSinceEpoch}.m4a';

//       await _recorder.start(path: path);
//       setState(() {
//         _isRecording = true;
//         _filePath = path;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Microphone permission denied')),
//       );
//     }
//   }

//   Future<void> _stopRecording() async {
//     await _recorder.stop();
//     setState(() => _isRecording = false);

//     if (_filePath != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Saved to $_filePath')),
//       );
//       Navigator.pop(context, _filePath); // return path to caller
//     }
//   }

//   @override
//   void dispose() {
//     _recorder.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Note for ${widget.contactName}')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               _isRecording ? Icons.mic : Icons.mic_none,
//               size: 64,
//               color: _isRecording ? Colors.red : Colors.grey,
//             ),
//             const SizedBox(height: 20),
//             _isRecording
//                 ? ElevatedButton.icon(
//                     icon: const Icon(Icons.stop),
//                     label: const Text('Stop Recording'),
//                     onPressed: _stopRecording,
//                   )
//                 : ElevatedButton.icon(
//                     icon: const Icon(Icons.fiber_manual_record),
//                     label: const Text('Start Recording'),
//                     onPressed: _startRecording,
//                   ),
//             const SizedBox(height: 20),
//             const Text('Tap to record a note for this call.'),
//           ],
//         ),
//       ),
//     );
//   }
// }
