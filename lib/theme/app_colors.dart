import 'package:flutter/material.dart';

class AppColors {
  // Figma / brand palette pulled from your code
  static const bgTop = Color(0xFFFFFFFF);
  static const bgMid = Color(0xFFEDEDED);
  static const bgBottom = Color(0xFFD8DBD8);

  //static const teal = Color(0xFF0B8A83);
  static const tealDark = Color(0xFF0A6E68);
    static const teal = Color(0xFF057B99);

  // Common gradients
  static const buttonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0FA59D), tealDark],
  );

  static const pageGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgTop, bgMid, bgBottom],
    stops: [0.0, 0.55, 1.0],
  );
}
