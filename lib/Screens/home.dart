import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking_system/handler/mapfunctions.dart';
import 'package:smart_parking_system/tools/bottomDrawer.dart';
import '../design_system/glassmorphism.dart';
import '../tools/map.dart';
import '/design_system/styles.dart';
import '../tools/navigation_drawer.dart';

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
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MapFunctions>(context);
    var scrSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(scrSize.width, 60),
        child: FrostedAppBar(
          elevation: 10,
          icon: const Icon(
            Icons.menu_rounded,
            size: 28,
          ),
          actions: [
            Container(
              // width: 48,
              // height: 48,
              margin: const EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                  color: AppColors.mapLight.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(56))),
              child: SizedBox(
                width: 56,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  color: AppColors.dark,
                  //iconSize: 20,
                  icon: const Icon(
                    Icons.notifications_rounded,
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
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
      bottomSheet: const BottomDrawer(
        length: DrawerLength.defult,
        searchBarAtDown: true,
      ),
      body: (appState.position == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(
                children: [
                  const AppMap(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: scrSize.width,
                        height: 150,
                        padding: const EdgeInsets.only(right: 30),
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: FloatingActionButton(
                              onPressed: () {
                                appState.getCurrentLocation();
                                setState(() {
                                  appState.onCreated;
                                  appState.mapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          appState.lastPosition));
                                });
                              },
                              tooltip: 'My location',
                              backgroundColor: AppColors.appBlue,
                              child: const Icon(
                                Icons.add_location,
                                color: AppColors.light,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
