// ignore: file_names
import 'package:flutter/material.dart';
import 'package:smart_parking_system/design_system/styles.dart';
//import 'package:smart_parking_system/tools/custom_gesture.dart';
import 'package:smart_parking_system/tools/searchbar.dart';

class BottomDrawer extends StatelessWidget {
  final Widget? child;
  final bool searchBarAtDown; // = DrawerLength.defult;
  const BottomDrawer({
    Key? key,
    this.child,
    required this.searchBarAtDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SearchBar searchBar = Provider.of<SearchBar>(context);
    return Positioned(
      left: 0,
      bottom: 0,
      child: Container(
        height: 110,
        decoration: const BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: CardWidget(
          searchBarAtDown: searchBarAtDown,
          elements: child,
        ),
      ),
    );
  }

  // double drawerLength(DrawerLength length, SearchBarState searchBarState) {
  //   double hide = 0;
  //   // if (searchBarState == SearchBarState.onTyped) {
  //   //   length == DrawerLength.long;
  //   //   hide = 0;
  //   // } else if (searchBarState == SearchBarState.onTapped) {
  //   //   length == DrawerLength.mid;
  //   //   hide = -510;
  //   // } else if (searchBarState == SearchBarState.defult) {
  //   //   length == DrawerLength.defult; //required
  //   //   hide = -610;
  //   // }
  //   if (length == DrawerLength.long ||
  //       searchBarState == SearchBarState.onTyped) {
  //     hide = 0;
  //   } else if (length == DrawerLength.mid ||
  //       searchBarState == SearchBarState.onTapped) {
  //     hide = -510;
  //   } else if (length == DrawerLength.defult ||
  //       searchBarState == SearchBarState.defult) {
  //     hide = -610;
  //   }
  //   return hide;
  // }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.elements,
    required this.searchBarAtDown,
  }) : super(key: key);
  final Widget? elements;
  final bool searchBarAtDown;

  @override
  Widget build(BuildContext context) {
    //SearchBar searchBar = Provider.of<SearchBar>(context);
    var scrSize = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        // Container(
        //   height: 110,
        //   width: scrSize.width,
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(0),
        //       bottomRight: Radius.circular(0),
        //     ),
        //   ),
        //   child: elements,
        // ),
        Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF000000),
                offset: Offset.zero,
                blurRadius: 0.0,
                spreadRadius: 0.0,
                blurStyle: BlurStyle.normal,
              ),
            ],
            borderRadius: BorderRadius.circular(2.50),
            color: AppColors.light,
          ),
        ),
        searchBarAtDown ? SearchBar(top: 15) : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
      ],
      //),
    );
  }
}
