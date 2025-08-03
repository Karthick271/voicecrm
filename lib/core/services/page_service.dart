import 'package:flutter/material.dart';

class PageService {
  static List<Widget> getPages() {
    return [
      PlaceholderScreen(label: 'Home'),
      PlaceholderScreen(label: 'Search'),
      PlaceholderScreen(label: 'Profile'),
    ];
  }
}

// Simple placeholder screen you can use anywhere
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
