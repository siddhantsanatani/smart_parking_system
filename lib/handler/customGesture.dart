import 'package:flutter/cupertino.dart';

class CustomGestureDetector extends StatelessWidget {
  static const int axisX = 0;
  static const int axisY = 1;
  static const int axisBoth = 2;

  final int axis;
  final Widget child;
  final double velocity;
  final Function? onSwipeUp;
  final Function? onSwipeDown;
  final Function? onSwipeLeft;
  final Function? onSwipeRight;

  const CustomGestureDetector(
      {Key? key,
      required this.child,
      required this.velocity,
      this.onSwipeLeft,
      this.onSwipeRight,
      this.onSwipeUp,
      this.onSwipeDown,
      required this.axis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanEnd: (details) {
          Offset v = details.velocity.pixelsPerSecond;

          try {
            if ((axis == axisY) || axis == axisBoth) {
              if (v.dy > velocity) {
                onSwipeDown!();
              } else if (v.dy < -velocity) {
                onSwipeUp!();
              }
            }

            if ((axis == axisX) || axis == axisBoth) {
              if (v.dx > velocity) {
                onSwipeRight!();
              } else if (v.dx < -velocity) {
                onSwipeLeft!();
              }
            }
          } catch (e) {
            debugPrintStack(
                label:
                    "******************FUNCTIONS NOT DEFINED*********************",
                stackTrace: StackTrace.fromString(
                    "Please define the functions for given AXIS constant - CustomGestureDetector"));
          }
        },
        child: child);
  }
}
