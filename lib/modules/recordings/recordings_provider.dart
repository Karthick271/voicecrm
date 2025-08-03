import 'package:flutter_riverpod/flutter_riverpod.dart';

final recordingsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      'contact': 'Alice',
      'phone': '+91 98765 43210',
      'duration': '00:03:21',
      'date': '2025-08-03 11:22',
    },
    {
      'contact': 'CRM Support',
      'phone': '+91 90000 11111',
      'duration': '00:01:12',
      'date': '2025-08-02 16:30',
    },
  ];
});
