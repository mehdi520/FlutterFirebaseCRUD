import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
   TextStyle? style;
  final Gradient gradient = LinearGradient(
    colors: <Color>[
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.red,
      Colors.yellow,
    ],
  );

  GradientText({
    required this.text,
    this.style

  });

  @override
  Widget build(BuildContext context) {
    if(style == null)
      {
        style = TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        );
      }
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style!.copyWith(color: Colors.white), // Set color to white
      ),
    );
  }
}
