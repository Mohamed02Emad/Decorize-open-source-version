import 'package:flutter/cupertino.dart';
import 'package:nav/nav.dart';

Future<void> popToFirst(BuildContext context) async {
  while (await Nav.canPop(context: context)) {
    Nav.pop(context);
  }
}
