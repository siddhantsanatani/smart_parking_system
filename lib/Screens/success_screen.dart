import 'package:flutter/material.dart';
import 'package:smart_parking_system/Screens/home.dart';
import 'package:smart_parking_system/design_system/styles.dart';

class SuccessScreen extends StatefulWidget {
  static String id = 'success_screen';

  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuccessScreen();
}

class _SuccessScreen extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    navigateHome();
  }

  navigateHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushNamed(context, HomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
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
              width: scrSize.width,
              height: 240,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    // padding: const EdgeInsets.all(25),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.pink,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Header2(text: "Success!", color: AppColors.pink),
                  const SizedBox(height: 15),
                  const SizedBox(
                      width: 335,
                      child: BodyText(
                          align: TextAlign.center,
                          text:
                              'Congrats, your account\nhas been successfully created',
                          color: AppColors.white)),
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
