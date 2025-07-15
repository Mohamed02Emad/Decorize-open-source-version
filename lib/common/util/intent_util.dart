import 'package:easy_localization/easy_localization.dart';
import 'package:decorizer/common/util/ui_helper.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

openWhatsApp({required String number}) async {
  String whatsappUrl = 'https://api.whatsapp.com/send?phone=$number';
  await canLaunch(whatsappUrl)
      ? launch(whatsappUrl)
      : showErrorToast('could_not_launch_whatsapp'.tr());
}

openFacebook({required String url}) async {
  await canLaunch(url)
      ? launch(url)
      : showErrorToast('could_not_launch_facebook'.tr());
}

openInstagram({required String url}) async {
  await canLaunch(url)
      ? launch(url)
      : showErrorToast('could_not_launch_instagram'.tr());
}

openSnapchat({required String url}) async {
  await canLaunch(url)
      ? launch(url)
      : showErrorToast('could_not_launch_snapchat'.tr());
}

openWebIntent({required String url}) async {
  await canLaunch(url) ? launch(url) : showErrorToast('could_not_open'.tr());
}

openX({required String url}) async {
  try {
    await launch(url);
  } catch (e) {
    await launch(url);
    showErrorToast('could_not_launch_x_app'.tr());
  }
}

makePhoneCall(String number) async {
  final String url = 'tel:$number';
  try {
    await launch(url);
  } catch (e) {
    copyToClipboard(number);
    throw '${'could_not_open'.tr()} $number';
  }
}

void sendMail(String email) async {
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  try {
    await launch(_emailLaunchUri.toString());
  } catch (e) {
    copyToClipboard(email);
    throw 'Could not launch $email';
  }
}

void openMapsApp(double lat, double lng) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch Maps';
  }
}

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
  showSuccessToast('copied_to_clipboard'.tr());
}
