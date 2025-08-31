// // recording_card.dart
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:intl/intl.dart';
// import 'recording_model.dart';

// class RecordingCard extends StatefulWidget {
//   final RecordingModel recording;
//   const RecordingCard({super.key, required this.recording});

//   @override
//   State<RecordingCard> createState() => _RecordingCardState();
// }

// class _RecordingCardState extends State<RecordingCard> {
//   final AudioPlayer _player = AudioPlayer();
//   bool _isPlaying = false;

//   @override
//   void dispose() {
//     _player.dispose();
//     super.dispose();
//   }

//   Future<void> _playPause() async {
//     if (_isPlaying) {
//       await _player.pause();
//       setState(() => _isPlaying = false);
//     } else {
//       await _player.play(DeviceFileSource(widget.recording.filePath));
//       setState(() => _isPlaying = true);
//       _player.onPlayerComplete.listen((_) {
//         if (mounted) setState(() => _isPlaying = false);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final rec = widget.recording;
//     final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(rec.dateTime);
//     final formattedDuration =
//         '${rec.duration.inMinutes}:${(rec.duration.inSeconds % 60).toString().padLeft(2, '0')}';

//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         leading: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle, color: Colors.blue, size: 36),
//         title: Text(rec.contact),
//         subtitle: Text('$formattedDate • $formattedDuration'),
//         trailing: IconButton(
//           icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
//           onPressed: _playPause,
//         ),
//       ),
//     );
//   }
// }
