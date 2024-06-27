import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.background;

    return Container(
      color: backgroundColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}