import 'package:flutter/material.dart';

class AppColors extends Color {
  static const appBlue = Color(0xff567df4);
  static const pink = Color(0xffff317b);
  static const dark = Color(0xff192242);
  static const overlay = Color(0xe5192342);
  static const grey = Color(0xff677191);
  static const darkNavy = Color(0xff253c59);
  static const navy = Color(0xff2d4b73);
  static const lightBlue = Color(0xffb6c7ff);
  static const violet = Color(0xff7b61ff);
  static const white2 = Color(0xffe2e9fd);
  static const light = Color(0xfff3f6ff);
  static const mapDark = Color(0xff121a30);
  static const mapLight = Color(0xfffafbff);
  static const white = Colors.white;

  AppColors(int value) : super(value);
}

class Logo extends StatelessWidget {
  final String text;
  final Color color;
  final double? size;
  const Logo({Key? key, required this.text, required this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size ?? 54,
        fontFamily: "Josefin",
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Header1 extends StatelessWidget {
  final String? text;
  final Color color;
  const Header1({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: 32,
        fontFamily: "Lato",
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Header2 extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final Color color;
  const Header2({Key? key, required this.text, required this.color, this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: 24,
        fontFamily: "Lato",
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Header3 extends StatelessWidget {
  final String text;
  final Color color;
  const Header3({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontFamily: "Lato",
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Link extends StatelessWidget {
  final String? text;
  final Color color;
  const Link({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: "Lato",
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class SubHead extends StatelessWidget {
  final String? text;
  final Color color;
  const SubHead({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: "Lato",
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign? align;
  const BodyText(
      {Key? key, required this.text, required this.color, this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: "Lato",
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String? text;
  final Color color;
  const Label({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: 14,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class RoadName extends StatelessWidget {
  final String? text;
  final Color color;
  const RoadName({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontFamily: "Lato",
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class Sign extends StatelessWidget {
  final String? text;
  final Color color;
  const Sign({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontFamily: "Lato",
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
