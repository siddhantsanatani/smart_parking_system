import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking_system/Screens/welcome_screen.dart';
import 'package:smart_parking_system/handler/mapfunctions.dart';
import 'package:smart_parking_system/tools/bottomDrawer.dart';
import 'package:smart_parking_system/tools/searchbar.dart';
import 'Screens/success_screen.dart';
import 'handler/mapfunctions.dart';
import 'Screens/login_screen.dart';
import 'Screens/home.dart';
import 'Screens/registration_screen.dart';
import 'handler/appdata.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<AppData>(create: (_) => AppData()),
        ChangeNotifierProvider.value(
          value: MapFunctions(),
        ),
        ChangeNotifierProvider.value(
          value: SearchBar(),
        )
        // Provider<SearchBar>(create: (_) => SearchBar()),
        // Provider<AnotherThing>(create: (_) => AnotherThing()),
      ],
      child: MaterialApp(
        title: 'Custom Fonts',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Lato'),
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          WizardFormLogIn.id: (context) => const WizardFormLogIn(),
          WizardFormReg.id: (context) => const WizardFormReg(),
          SuccessScreen.id: (context) => const SuccessScreen(),
          WelcomeScreen.id: (context) => const WelcomeScreen(),
        },
        initialRoute: WelcomeScreen.id,
        home: const HomeScreen(),
      ),
    ),
  );
}

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return const HomeScreen();
//   }
// }
