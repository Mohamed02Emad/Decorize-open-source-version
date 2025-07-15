import 'package:flutter/cupertino.dart';

class Width extends StatelessWidget {
  final double width;
  const Width(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class Height extends StatelessWidget {
  final double height;
  const Height(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
