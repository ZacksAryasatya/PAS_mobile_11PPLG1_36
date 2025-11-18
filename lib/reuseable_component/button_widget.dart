import 'package:flutter/material.dart';

class Frame4Button extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double elevation;
  final Color color;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const Frame4Button({
    super.key,
    required this.onPressed,
    this.textStyle,
    required this.text,
    required this.width,
    required this.height,
    required this.elevation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
