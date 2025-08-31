import 'package:flutter/material.dart';

class SplashMessage extends StatelessWidget {
  const SplashMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Simple and Smart.',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
