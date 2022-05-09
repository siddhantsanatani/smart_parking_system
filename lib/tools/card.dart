import 'package:flutter/material.dart';
import '/design_system/styles.dart';
import 'searchbar.dart';

class AppCard extends StatelessWidget {
  final Widget? elements;
  final bool searchBarAtDown;
  const AppCard({
    Key? key,
    this.elements,
    required this.searchBarAtDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: scrSize.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: elements,
        ),
        Positioned(
          top: 10,
          child: Container(
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
        ),
        searchBox(searchBarAtDown)
      ],
    );
  }

  Widget searchBox(searchBarAtDown) {
    if (searchBarAtDown) {
      return SearchBar(top: 20);
    } else {
      return const SizedBox();
    }
  }
}
