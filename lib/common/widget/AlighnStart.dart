import 'package:flutter/cupertino.dart';

class AlignStartHorizontal extends StatelessWidget {
  final Widget child;

  const AlignStartHorizontal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[child],
    );
  }
}
