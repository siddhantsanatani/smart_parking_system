import 'package:flutter/material.dart';
import 'package:smart_parking_system/design_system/styles.dart';
import 'package:smart_parking_system/tools/button.dart';

import '../Screens/login_screen.dart';
import '../Screens/registration_screen.dart';

class BuildUser extends StatefulWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final String? urlImage;
  final String? name;
  final String? email;
  final VoidCallback? onClicked;

  const BuildUser({
    Key? key,
    this.name,
    this.email,
    this.onClicked,
    this.urlImage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoggedIn();

  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 3,
              child: Icon(
                Icons.person_add_alt_1,
                size: 55,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButtonStyle(
                      action: () => selectedItem(context, 0),
                      buttonText: "Sign In",
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      buttonTextColor: AppColors.white,
                      buttonBgColor: AppColors.appBlue.withOpacity(0.8),
                      buttonWidth: 50),
                  AppButtonStyle(
                      action: () => selectedItem(context, 1),
                      buttonText: "Register",
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      buttonTextColor: AppColors.white,
                      buttonBgColor: AppColors.pink.withOpacity(0.8),
                      buttonWidth: 50)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const WizardFormLogIn(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const WizardFormReg(),
        ));
        break;
    }
  }
}

class _LoggedIn extends State<BuildUser> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClicked,
      child: Container(
        padding: widget.padding.add(const EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(
                radius: 30, backgroundImage: NetworkImage(widget.urlImage!)),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name!,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.email!,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            const Spacer(),
            const CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              child: Icon(Icons.add_comment_outlined, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
