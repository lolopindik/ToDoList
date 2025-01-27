import 'package:flutter/material.dart';

class TransitionAnimation {
  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin =
            Offset(0.0, 1.0); //* Начало анимации (страница появляется снизу)
        const end = Offset.zero; //* Конечная точка
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

abstract class DetailsTransitionAnimation extends TransitionAnimation {
  static Route createRoute(Widget page, Offset tapPosition) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final progress = animation.value;
            final screenSize = MediaQuery.of(context).size;
            final maxRadius = screenSize.longestSide;
            final radius = maxRadius * progress;

            return Stack(
              children: [
                Positioned(
                  left: tapPosition.dx - radius,
                  top: tapPosition.dy - radius,
                  child: ClipOval(
                    child: SizedBox(
                      width: radius * 2,
                      height: radius * 2,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                SlideTransition(
                  position: Tween(
                    begin:
                        const Offset(0.0, 1.0), //* Текущая страница уходит вниз
                    end: const Offset(0.0, 0.5), //* Останавливается на середине
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                  )),
                  child: child,
                ),
                Opacity(
                  opacity: progress,
                  child: child,
                ),
              ],
            );
          },
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }
}
