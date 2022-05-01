import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../design_system/styles.dart';

class AppButtonStyle extends StatefulWidget {
  final VoidCallback? action;
  final String buttonText;
  final Color? buttonBgColor;
  final Color? buttonTextColor;
  final Color? buttonBorderColor;
  final double buttonWidth;
  final double? buttonHeight;
  final EdgeInsetsGeometry? padding;

  const AppButtonStyle(
      {Key? key,
      required this.action,
      required this.buttonText,
      this.buttonTextColor,
      this.buttonBgColor,
      this.buttonHeight,
      required this.buttonWidth,
      this.buttonBorderColor,
      this.padding})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppButtonStyleState();
}

class _AppButtonStyleState extends State<AppButtonStyle> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return widget.buttonTextColor ?? AppColors.dark;
      }
      return widget.buttonBgColor ?? AppColors.appBlue;
    }

    BorderSide getBorderColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return BorderSide(
            color: widget.buttonBorderColor ?? AppColors.white, width: 3);
      }
      return BorderSide(
          color: widget.buttonBorderColor ?? AppColors.dark.withOpacity(0),
          width: 0);
    }

    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(widget.padding),
        backgroundColor: MaterialStateProperty.resolveWith(getColor),
        elevation: MaterialStateProperty.all(10),
        alignment: Alignment.center,
        minimumSize: MaterialStateProperty.all(
            Size(widget.buttonWidth, widget.buttonHeight ?? 55)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        side: MaterialStateProperty.resolveWith(getBorderColor),
      ),
      onPressed: widget.action,
      child: Header3(
        text: widget.buttonText,
        color: widget.buttonTextColor ?? AppColors.dark,
      ),
    );
  }
}
