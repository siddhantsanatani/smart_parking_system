import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:smart_parking_system/Screens/home.dart';

import '../design_system/styles.dart';

enum AnimProps {
  opacity,
  width,
  height,
  padding,
  borderRadius,
  color,
}

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late Animation<TimelineValue<AnimProps>> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    controller.forward();
    controller.addStatusListener((status) {
      // setState(() {});
      if (controller.isCompleted) {
        Navigator.popAndPushNamed(context, HomeScreen.id);
      }
    });
    // animation = TimelineTween<AnimProps>()
    //     .addScene(
    //       begin: 0.milliseconds,
    //       end: 100.milliseconds,
    //       curve: Curves.ease,
    //     )
    //     .animate(AnimProps.opacity, tween: Tween(begin: 0.0, end: 1.0))
    //     .addSubsequentScene(
    //       delay: 25.milliseconds,
    //       duration: 125.milliseconds,
    //       curve: Curves.ease,
    //     )
    //     .animate(AnimProps.width, tween: Tween(begin: 50.0, end: 150.0))
    //     // Height and Padding
    //     .addSubsequentScene(
    //       duration: 125.milliseconds,
    //       curve: Curves.ease,
    //     )
    //     .animate(AnimProps.height, tween: Tween(begin: 50.0, end: 150.0))
    //     .animate(
    //       AnimProps.padding,
    //       tween: EdgeInsetsTween(
    //         begin: const EdgeInsets.only(bottom: 16.0),
    //         end: const EdgeInsets.only(bottom: 75.0),
    //       ),
    //     )
    //     // BorderRadius
    //     .addSubsequentScene(
    //       duration: 125.milliseconds,
    //       curve: Curves.ease,
    //     )
    //     .animate(
    //       AnimProps.borderRadius,
    //       tween: BorderRadiusTween(
    //         begin: BorderRadius.circular(4.0),
    //         end: BorderRadius.circular(75.0),
    //       ),
    //     )
    //     // Color
    //     .addSubsequentScene(
    //       duration: 250.milliseconds,
    //       curve: Curves.ease,
    //     )
    //     .animate(
    //       AnimProps.color,
    //       tween: ColorTween(
    //         begin: Colors.indigo[100],
    //         end: Colors.orange[400],
    //       ),
    //     )
    //     // Get the Tween so that we can drive it with the AnimationController
    //     .parent
    //     .animatedBy(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightBlue,
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Image.asset("images/success_top.png"),
              alignment: Alignment.topRight,
              width: scrSize.width,
            ),
            SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        '.',
                        curve: Curves.linear,
                        textStyle: const TextStyle(
                          color: AppColors.pink,
                          fontSize: 96,
                          fontFamily: "Josefin",
                          fontWeight: FontWeight.w700,
                        ),
                        speed: const Duration(milliseconds: 20),
                      ),
                    ],
                  ),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText('Park',
                          // cursor: '',
                          curve: Curves.linear,
                          textAlign: TextAlign.right,
                          textStyle: const TextStyle(
                            color: AppColors.darkNavy,
                            fontSize: 50,
                            fontFamily: "Josefin",
                            fontWeight: FontWeight.w700,
                          ),
                          //rotateOut: false,
                          speed: const Duration(milliseconds: 300)),
                    ],
                  ),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        '.',
                        curve: Curves.linear,
                        textStyle: const TextStyle(
                          color: AppColors.pink,
                          fontSize: 96,
                          fontFamily: "Josefin",
                          fontWeight: FontWeight.w700,
                        ),
                        speed: const Duration(milliseconds: 20),
                      ),
                    ],
                  ),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText('Inn',
                          // cursor: '',
                          curve: Curves.linear,
                          textStyle: const TextStyle(
                            color: AppColors.darkNavy,
                            fontSize: 50,
                            fontFamily: "Josefin",
                            fontWeight: FontWeight.w700,
                          ),
                          //rotateOut: false,
                          speed: const Duration(milliseconds: 300)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Image.asset("images/success_bottom.png"),
              alignment: Alignment.bottomLeft,
              width: scrSize.width,
            ),
          ],
        ),
      ),
    );
  }
}
