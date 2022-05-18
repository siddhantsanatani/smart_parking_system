import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking_system/Screens/success_screen.dart';
import 'package:smart_parking_system/tools/bottom_drawer.dart';
import '/design_system/styles.dart';
import '../handler/mapfunctions.dart';

enum SearchBarState { onTapped, onTyped, onComplete, defult }

// ignore: must_be_immutable
class SearchBar extends StatelessWidget with ChangeNotifier {
  final double top;
  final double left;
  final double right;
  final double bottom;
  final double width;
  final double height;
  final TextEditingController searchBarController = TextEditingController();
  SearchBarState searchBarState = SearchBarState.defult;
  SearchBar({
    Key? key,
    this.top = 0,
    this.bottom = 0,
    this.height = 50,
    this.left = 10,
    this.right = 10,
    this.width = double.infinity,
    //required this.searchBarController
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MapFunctions>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchBarController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                constraints: BoxConstraints.tight(Size(width, height)),
                prefixIcon: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    // color: AppColors.light,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  margin: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                  child: const Icon(Icons.search_outlined),
                ),
                focusColor: AppColors.lightBlue,
                fillColor: AppColors.mapLight,
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.0, color: AppColors.appBlue),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                label: const BodyText(
                  text: 'Enter Your Destination',
                  color: AppColors.dark,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, SuccessScreen.id);
                searchBarState = SearchBarState.onTapped;
                const BottomDrawer(
                    searchBarAtDown: true, length: DrawerLength.mid);
                notifyListeners();
              },
              onEditingComplete: () {
                searchBarState = SearchBarState.onComplete;
                appState.sendDestinationRequest(searchBarController.text);
                notifyListeners();
              },
              // onChanged: (text) {
              //   searchBarState = SearchBarState.onTyped;
              //   notifyListeners();
              // },
              onFieldSubmitted: (text) {
                appState.sendDestinationRequest(text);
              },
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkNavy.withOpacity(0.5),
                  offset: Offset.zero,
                  blurRadius: 1,
                  spreadRadius: 0,
                  blurStyle: BlurStyle.normal,
                ),
              ],
              color: AppColors.light,
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.all(4),
            child: const Center(child: Icon(Icons.mic_rounded)),
          ),
        ],
      ),
    );
  }
}
