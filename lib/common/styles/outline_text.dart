import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color outlineColor;
  final double outlineWidth;
  final TextAlign textAlign;

  const OutlinedText({
    Key? key,
    required this.text,
    required this.style,
    required this.outlineColor,
    required this.outlineWidth,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Outline Text
        Text(
          text,
          textAlign: textAlign,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..color = outlineColor,
          ),
        ),
        // Solid Text
        Text(
          text,
          textAlign: textAlign,
          style: style,
        ),
      ],
    );
  }
}
