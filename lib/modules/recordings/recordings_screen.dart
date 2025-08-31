// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../presentation/widgets/custom_app_bar.dart';
// import 'recording_card.dart';
// import 'recordings_provider.dart';

// class RecordingsScreen extends ConsumerWidget {
//   const RecordingsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final recordings = ref.watch(recordingsProvider);

//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Recordings'),
//       body: recordings.isEmpty
//           ? const Center(child: Text('No recordings yet.'))
//           : ListView.builder(
//               itemCount: recordings.length,
//               itemBuilder: (context, index) {
//                 final rec = recordings[index];
//                 return RecordingCard(recording: rec);
//               },
//             ),
//     );
//   }
// }
