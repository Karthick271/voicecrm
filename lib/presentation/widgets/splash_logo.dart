import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // You can replace this with your own logo/image if you want!
    return Icon(
      Icons.flutter_dash,
      color: Theme.of(context).colorScheme.primary,
      size: 64,
    );
    // Or use:
    // return Image.asset('assets/images/your_logo.png', width: 120);
  }
}
