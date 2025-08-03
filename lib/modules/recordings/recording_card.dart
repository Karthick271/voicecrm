import 'package:flutter/material.dart';

class RecordingCard extends StatelessWidget {
  final String contact;
  final String phone;
  final String duration;
  final String date;
  final VoidCallback onUpload;

  const RecordingCard({
    super.key,
    required this.contact,
    required this.phone,
    required this.duration,
    required this.date,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.mic),
        title: Text('$contact ($phone)'),
        subtitle: Text('$date • $duration'),
        trailing: IconButton(
          icon: const Icon(Icons.cloud_upload),
          onPressed: onUpload,
        ),
      ),
    );
  }
}
