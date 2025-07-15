import 'package:flutter/cupertino.dart';

class CenterHorizontal extends StatelessWidget {
  final Widget child;

  const CenterHorizontal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [child],
    );
  }
}
