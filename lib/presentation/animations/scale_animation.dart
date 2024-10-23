import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScaleAnimation {
  Widget createAnimation(BuildContext context, Widget child) {
    return Animate(
      effects: const [ScaleEffect(duration: Duration(milliseconds: 150))],
      child: child,
    );
  }
}
