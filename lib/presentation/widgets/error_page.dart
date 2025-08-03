import 'package:flutter/material.dart';

import '../../widgets/empty_state_widget.dart';
 
class ErrorPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onRetry;
  final Color? backgroundColor; // Optional background color

  // Constructor with parameters
  const ErrorPage({
    required this.title,
    required this.subtitle,
    this.onRetry,
    this.backgroundColor = Colors.white, // Default background color is white
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // Set background color from passed parameter
      body: Center(
        child: EmptyStateWidget(
          title: title,
          subtitle: subtitle, message: 'Network unreachable. Please try again.',
         ),
      ),
    );
  }
}
