import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/tools/widget.dart';
import '../design_system/glassmorphism.dart';
import '../tools/map.dart';
import '/design_system/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_parking_system/tools/card.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(scrSize.width, 50),
        child: FrostedAppBar(
          elevation: 10,
          icon: const Icon(
            MyFlutterApp.menu,
            size: 28,
          ),
          actions: [
            Container(
              height: 50,
              margin: const EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                  color: AppColors.mapLight.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(56))),
              child: IconButton(
                color: AppColors.dark,
                icon: const Icon(
                  Icons.notifications_rounded,
                ),
                onPressed: () {
                  // do something
                },
              ),
            ),
          ],
          logo: const Logo(
            text: 'Park.Inn',
            color: AppColors.dark,
            size: 32,
          ),
        ),
      ),
      drawer: const NavigationDrawerWidget(),
      body: SafeArea(
        child: Stack(
          children: [
            const AppMap(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 30),
                  child: FloatingActionButton(
                      onPressed: () {},
                      tooltip: 'Add Marker',
                      backgroundColor: AppColors.appBlue,
                      child: const Icon(
                        Icons.add_location,
                        color: AppColors.light,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 110,
                  child: AppCard(
                    searchBarAtDown: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
