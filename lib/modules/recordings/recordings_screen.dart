import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import 'recording_card.dart';
import 'recordings_provider.dart';
 
class RecordingsScreen extends ConsumerWidget {
  const RecordingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordings = ref.watch(recordingsProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Recordings'),
      body: ListView.builder(
        itemCount: recordings.length,
        itemBuilder: (context, index) {
          final rec = recordings[index];
          return RecordingCard(
            contact: rec['contact']!,
            phone: rec['phone']!,
            duration: rec['duration']!,
            date: rec['date']!,
            onUpload: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pretend uploading to CRM...')),
              );
            },
          );
        },
      ),
    );
  }
}
