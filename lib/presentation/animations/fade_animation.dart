import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeAnimation {
  Widget createAnimation(BuildContext context, Widget child) {
    return Animate(
      effects: const [
        FadeEffect(
          duration: Duration(milliseconds: 1500),
        ),
      ],
      child: child,
    );
  }
}
