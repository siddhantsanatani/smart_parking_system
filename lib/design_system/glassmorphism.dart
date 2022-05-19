import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_parking_system/design_system/styles.dart';

class FrostedAppBar extends StatefulWidget {
  //
  final double? elevation;
  final Widget? title;
  final Widget icon;
  final void Function()? onPressActions;
  final List<Widget>? actions;
  final Color? color;
  final double? blurStrengthX;
  final double? blurStrengthY;
  final Widget logo;
  //constructor
  const FrostedAppBar({
    Key? key,
    this.elevation,
    this.onPressActions,
    this.blurStrengthX,
    this.blurStrengthY,
    this.actions,
    this.color,
    required this.icon,
    this.title,
    required this.logo,
  }) : super(key: key);
  //
  @override
  _FrostedAppBarState createState() => _FrostedAppBarState();
}

class _FrostedAppBarState extends State<FrostedAppBar> {
  @override
  Widget build(BuildContext context) {
    //var scrSize = MediaQuery.of(context).size;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          // will be 10 by default if not provided
          sigmaX: widget.blurStrengthX ?? 10,
          sigmaY: widget.blurStrengthY ?? 10,
        ),
        child: AppBar(
          elevation: widget.elevation ?? 0,
          centerTitle: true,
          actions: widget.actions,
          title: widget.logo,
          leadingWidth: 70,
          backgroundColor: AppColors.white.withOpacity(0.5),
          leading: Container(
            height: 56,
            margin: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
                color: AppColors.mapLight.withOpacity(0.4),
                borderRadius: const BorderRadius.all(Radius.circular(56))),
            child: IconButton(
              color: AppColors.dark,
              // iconSize: 36,
              icon: widget.icon,
              onPressed: widget.onPressActions ??
                  () {
                    Scaffold.of(context).openDrawer();
                  },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ),
      ),
    );
  }
}
