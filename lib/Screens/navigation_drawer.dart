import 'package:flutter/material.dart';
import 'package:smart_parking_system/Screens/login_screen.dart';
import 'package:smart_parking_system/Screens/registration_screen.dart';
import 'package:smart_parking_system/design_system/styles.dart';
import 'package:smart_parking_system/tools/user_bloc.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const name = 'Sarah Abs';
    const email = 'sarah@abs.com';
    const urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: AppColors.lightBlue,
        child: ListView(
          children: <Widget>[
            const BuildUser().build(context),
            Container(
              padding: padding,
              child: Column(
                children: [
                  // const SizedBox(height: 12),
                  // buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: "Nearby",
                    icon: Icons.car_repair,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "Saved",
                    icon: Icons.location_on,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "History",
                    icon: Icons.history,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "Payment",
                    icon: Icons.payment,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.black),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: "Support",
                    icon: Icons.contact_support,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: "Terms & Condition",
                    icon: Icons.text_snippet,
                    onClicked: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = AppColors.dark;
    final hoverColor = AppColors.dark.withOpacity(0.7);

    return ListTile(
      leading: Icon(icon, color: color),
      title: Header3(text: text, color: color),
      hoverColor: hoverColor,
      onTap: onClicked,
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
