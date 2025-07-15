import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/extentions/widget.dart';
import 'package:decorizer/common/resources/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void printStarLine() {
  print('*' * 150);
}

void mprint(String? message) {
  printStarLine();
  print('Mohamed : $message');
  printStarLine();
}

void showSnackbar({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}

class UiHelper {
  static void showSnackbar(BuildContext context) {
    context.showSnackbar(
      'snack-bar.',
      extraButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        alignment: Alignment.center,
        child: Text(
          'Show Error Button',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ).clickable(() {
        context.showErrorSnackbar('error');
      }),
    );
  }
}

showToast(String? message, {Color? bg}) {
  Fluttertoast.showToast(
    gravity: ToastGravity.TOP,
    backgroundColor: bg ?? Colors.black,
    textColor: Colors.white,
    msg: message.toString(),
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 2,
  );
}

showErrorToast(String? message) {
  showToast((message ?? LocaleKeys.error_error_happened).tr(), bg: Colors.red);
}

showSuccessToast(String message) {
  showToast(message.tr(), bg: Colors.green);
}
