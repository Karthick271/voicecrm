import 'package:flutter/material.dart';
import 'package:voicecrm/presentation/screens/contacts_screen.dart';

import '../../modules/contacts/contacts_screen.dart';
import '../../modules/dialer/dialer_screen.dart';
import '../../modules/call/call_screen.dart';
import '../../modules/recordings/recordings_screen.dart';
import '../../presentation/screens/call_history_live_page.dart';

class PageService {
  static List<Widget> getPages() {
    return [
      ContactsScreen(),
      CallHistoryLivePage(),
      // DialerScreen(),
      // CallScreen(contactName: 'Alice', phone: '+91 98765 43210'), // Replace with dynamic data when wiring up state
      // RecordingsScreen(),
      PlaceholderScreen(label: 'Profile'), // Replace with ProfileScreen() when you create it
    ];
  }
}

// Simple placeholder screen for unimplemented pages
class PlaceholderScreen extends StatelessWidget {
  final String label;
  const PlaceholderScreen({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(
        child: Text('Screen: $label', style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
