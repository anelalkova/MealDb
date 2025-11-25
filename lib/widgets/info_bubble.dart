import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoBubble extends StatelessWidget {
  final String text;
  final double opacity;

  const InfoBubble({
    super.key,
    required this.text,
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 228, 226, opacity),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
