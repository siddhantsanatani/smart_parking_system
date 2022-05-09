import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/tools/widget.dart';
import '../design_system/glassmorphism.dart';
import '../tools/map.dart';
import '/design_system/styles.dart';
import 'package:smart_parking_system/tools/card.dart';

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
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<AppState>(context);
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
            // Positioned(
            //   top: 105.0,
            //   right: 15.0,
            //   left: 15.0,
            //   child: Container(
            //     height: 50.0,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(3.0),
            //       color: Colors.white,
            //       boxShadow: const [
            //         BoxShadow(
            //             color: Colors.grey,
            //             offset: Offset(1.0, 5.0),
            //             blurRadius: 10,
            //             spreadRadius: 3)
            //       ],
            //     ),
            //     child: TextField(
            //       cursorColor: Colors.black,
            //       controller: AppState.destinationController,
            //       textInputAction: TextInputAction.go,
            //       onSubmitted: (value) {
            //         appState.sendPolyLineRequest(value);
            //       },
            //       decoration: InputDecoration(
            //         icon: Container(
            //           margin: const EdgeInsets.only(left: 20, top: 5),
            //           width: 10,
            //           height: 10,
            //           child: const Icon(
            //             Icons.local_taxi,
            //             color: Colors.black,
            //           ),
            //         ),
            //         hintText: "destination?",
            //         border: InputBorder.none,
            //         contentPadding:
            //             const EdgeInsets.only(left: 15.0, top: 16.0),
            //       ),
            //     ),
            //   ),
            // ),
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
